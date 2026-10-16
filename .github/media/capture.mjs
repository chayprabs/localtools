// Drive a running localtools tool with <slug>/media/demo.json and record it.
// Usage: node capture.mjs <slug> <port> <outdir>
// Writes <outdir>/raw.webm (light, 1280x800), screenshot.png (light) and screenshot-dark.png: 1280x800, or the element
// chosen by a {"screenshot": {"selector": ...}} step, captured at full height.
import { readFileSync, readdirSync, renameSync, mkdirSync } from "node:fs";
import { resolve } from "node:path";
import { chromium } from "playwright";

const [slug, port, out] = process.argv.slice(2);
const steps = JSON.parse(readFileSync(`${slug}/media/demo.json`, "utf8"));
if (!Array.isArray(steps) || !steps.length) throw new Error("demo.json must be a non-empty array of steps");
const base = `http://127.0.0.1:${port}`;
const size = { width: 1280, height: 800 };
const smoke = (f) => resolve(slug, "smoke", f);

let shot = null; // {"selector": "main", "maxHeight": 2000}: final screenshot = that element (full height, may exceed the viewport)
async function play(page) {
  for (const s of steps) {
    const [op, arg] = Object.entries(s)[0];
    switch (op) {
      case "goto": await page.goto(base + arg); break;
      case "fill": await page.fill(arg.selector, arg.text); break;
      case "setInputFiles": await page.setInputFiles(arg.selector, [].concat(arg.files).map(smoke)); break;
      case "click": await page.click(arg); break;
      case "waitFor":
        if (arg.selector) await page.waitForSelector(arg.selector, { state: "visible", timeout: 60000 });
        else await page.getByText(arg.text).first().waitFor({ timeout: 60000 });
        break;
      case "wait": await page.waitForTimeout(arg); break;
      case "scrollIntoView":
        await page.locator(arg).first().evaluate((el) => el.scrollIntoView({ block: "start", behavior: "smooth" }));
        await page.waitForTimeout(600); // let the smooth scroll finish
        break;
      case "screenshot": shot = arg; break; // applied to the final screenshot

      default: throw new Error(`unknown step ${op}`);
    }
    await page.waitForTimeout(s.pause ?? 400); // let the viewer see each step
  }
}

mkdirSync(out, { recursive: true });
const browser = await chromium.launch();
for (const scheme of ["light", "dark"]) {
  const ctx = await browser.newContext({ viewport: size, colorScheme: scheme, deviceScaleFactor: 1,
    ...(scheme === "light" ? { recordVideo: { dir: `${out}/rec`, size } } : {}) });
  const page = await ctx.newPage();
  await play(page);
  await page.waitForTimeout(1000);
  const path = `${out}/screenshot${scheme === "dark" ? "-dark" : ""}.png`;
  if (shot?.selector) {
    // Full page, clipped to the element, so a long result is not cut off at the fold.
    const box = await page.locator(shot.selector).first().evaluate((el) => {
      const r = el.getBoundingClientRect();
      return { x: r.left + scrollX, y: r.top + scrollY, width: r.width, height: r.height };
    });
    const pad = shot.padding ?? 24;
    const x = Math.max(0, box.x - pad), y = Math.max(0, box.y - pad);
    const clip = { x, y, width: Math.min(size.width - x, box.width + 2 * pad), height: Math.min(shot.maxHeight ?? 2400, box.height + 2 * pad) };
    await page.screenshot({ path, fullPage: true, clip });
  } else await page.screenshot({ path });
  await ctx.close(); // flushes the video
}
await browser.close();
const [rec] = readdirSync(`${out}/rec`);
renameSync(`${out}/rec/${rec}`, `${out}/raw.webm`);
