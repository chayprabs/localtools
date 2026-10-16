// Drive a running localtools tool with <slug>/media/demo.json and record it.
// Usage: node capture.mjs <slug> <port> <outdir>
// Writes <outdir>/raw.webm (light), screenshot.png (light) and screenshot-dark.png, all 1280x800.
import { readFileSync, readdirSync, renameSync, mkdirSync } from "node:fs";
import { resolve } from "node:path";
import { chromium } from "playwright";

const [slug, port, out] = process.argv.slice(2);
const steps = JSON.parse(readFileSync(`${slug}/media/demo.json`, "utf8"));
if (!Array.isArray(steps) || !steps.length) throw new Error("demo.json must be a non-empty array of steps");
const base = `http://127.0.0.1:${port}`;
const size = { width: 1280, height: 800 };
const smoke = (f) => resolve(slug, "smoke", f);

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
  await page.screenshot({ path: `${out}/screenshot${scheme === "dark" ? "-dark" : ""}.png` });
  await ctx.close(); // flushes the video
}
await browser.close();
const [rec] = readdirSync(`${out}/rec`);
renameSync(`${out}/rec/${rec}`, `${out}/raw.webm`);
