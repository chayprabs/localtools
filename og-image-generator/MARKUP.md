# OG Image Generator: template markup

A template is HTML with one `<style>` sheet and `{{placeholders}}`. It is parsed as data and laid out by
[satori](https://github.com/vercel/satori) 0.62 (its CSS subset: flex, grid, block, gradients, `line-clamp`,
`text-overflow`, CSS variables, `calc()`, `@media` on the image width/height/aspect-ratio). Nothing in it runs.

## Placeholders

| syntax | meaning |
|---|---|
| `{{title}}` | the field's text, HTML-escaped |
| `{{#logo}}…{{/logo}}` | keep the block only when the field is set |
| `{{^logo}}…{{/logo}}` | keep the block only when the field is empty |
| `{{#tags}}<span>{{.}}</span>{{/tags}}` | repeat per tag (`tags` is split on commas) |

Any name works (`{{price}}`): set it with `--field price=…` in the CLI or a `price` column in batch rows.

Fields filled in for you:

| field | value |
|---|---|
| `w`, `h` | image width and height in px |
| `scale` | `min(w/1200, h/630)` (portrait: `w/820`); multiply sizes by it: `calc({{scale}} * 48px)` |
| `titleSize` | a px size for the title that shrinks with its length |
| `bgCss` | `background`, or a 135° gradient to `background2` |
| `fg`, `muted`, `rule` | text, secondary text and hairline colours that contrast with `background` (`color` overrides `fg`) |
| `font` | the chosen family, quoted: `font-family: {{font}}` |
| `codeBg`, `codeFg`, `codeCols`, `codeRows` | colours of the code `theme`, and the columns/rows that fit the built-in code card |

## Header (optional)

```html
<!--og {"label": "My card", "defaults": {"background": "#101820", "accent": "#ff4d1a"}, "sample": {"title": "Shown in the UI"}} -->
```

`defaults` apply when a field is not given; `sample` only pre-fills the UI.

## Elements

- `<img src="{{logo}}">`: images must be uploads (`logo`, `avatar`, `backgroundImage`, `image`) or `data:` URLs.
  `http(s):`, `file:` and relative URLs, in attributes or CSS `url()`, are rejected with the line and column.
- `<code-block lang="typescript" theme="github-dark" cols="72" rows="10">{{code}}</code-block>`: Shiki
  highlighting; lines longer than `cols` and rows beyond `rows` are cut with `…`. Languages: bash, c, cpp, csharp,
  css, diff, docker, go, html, java, javascript, json, jsx, kotlin, php, python, ruby, rust, sql, swift, toml, tsx,
  typescript, yaml (plus aliases ts, js, py, sh, rs, yml, …). Themes: github-dark, github-light, vitesse-dark.
- Inline `<svg>` works. `<script>`, `<iframe>`, `<object>`, `<foreignObject>` and `on…=` handlers are rejected.

Avoid `overflow: hidden` on elements with many children: it makes rendering much slower.

## Fonts

Geist, Inter and JetBrains Mono are bundled; CJK (Noto Sans SC/JP/KR), Arabic, Hebrew, Devanagari and Twemoji emoji
are used automatically for text the chosen font lacks. Uploaded fonts (.ttf, .otf, .woff, .woff2) take their family
and weight from the file name: `Acme-Bold.ttf` is family `Acme`, weight 700.

## Limits

512 KiB raw markup, 5,000 elements, 100 levels of nesting, 2 MiB expanded template text; 200 to 4096 px per side. Uploaded images (up to 10 MiB / 25 MP each) are resolved after expansion and do not count toward its text limit. A card may contain at most 128 MiB of encoded image references. Inline data URLs still count toward the raw markup limit. Server jobs have a 20-second per-card / 15-minute per-batch deadline; CLI jobs run until finished or interrupted.
