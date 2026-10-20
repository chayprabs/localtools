# localtools-latex-to-svg

Render LaTeX math (or MathML, or AsciiMath) to self-contained SVG, PNG and MathML, with spoken alt text, on your own
machine. One page with a live preview, a CLI and a small HTTP API. Nothing is fetched from the network.

## Install

| OS | command |
|---|---|
| Windows (PowerShell) | `irm https://raw.githubusercontent.com/chayprabs/localtools/main/latex-to-svg/install.ps1 \| iex` |
| macOS / Linux | `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/latex-to-svg/install.sh \| bash` |
| Homebrew | `brew install chayprabs/localtools/localtools-latex-to-svg` |
| Scoop | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-latex-to-svg` |

npm (`localtools-latex-to-svg`, Node 22+) is prepared but not published yet.

## Use

Run `localtools-latex-to-svg`; the page opens at http://127.0.0.1:47133. Type a formula: the preview, the speech text,
the SVG and the MathML update as you type. Download SVG or PNG, or copy the SVG, the MathML, a `data:` URI or a ready
`<img>` tag (with alt text and baseline alignment). Errors say what is wrong and where (line and column).
The Batch tab takes a .tex, .md or .txt file (or pasted lines) and returns a zip of eq-001.svg/.png … plus manifest.json.

```sh
localtools-latex-to-svg render "\frac{a}{b}"                     # SVG to stdout
localtools-latex-to-svg render "\frac{a}{b}" -o eq.svg --png --scale 3   # eq.svg + eq.png (3x = 48 px font)
localtools-latex-to-svg render "E=mc^2" -o eq.png --dpi 300 --background white
localtools-latex-to-svg render "x^2" --speech                    # "x squared"
localtools-latex-to-svg render "sum_(i=1)^n i" --input asciimath --mathml
localtools-latex-to-svg batch paper.tex -o out/                   # every $..$, \[..\], equation/align... environment
localtools-latex-to-svg batch notes.md -o eqs.zip --png
```

Options: `--inline` (text style), `--color`, `--font-cache none|local`, `--macros FILE` (`\newcommand`s for every
formula), `--lines`/`--document`. In batch, a .tex file's balanced, possibly multiline `\newcommand`/`\def`/`\DeclareMathOperator`
definitions apply to its formulas; a failing formula is reported (stderr, manifest, exit code 1) and the rest are written.
Incomplete document definitions are skipped with a notice. Invalid definitions supplied through `--macros` identify the macros input.

API: `POST /api/render` (multipart: `math`, `input`, `display`, `fontCache`, `color`, `format` json|svg|png|mathml,
`scale`, `background`, `macros`) returns JSON `{svg, mathml, speech, warnings, fontCache, widthEx, heightEx, verticalAlignEx}` or the file;
`POST /api/batch` (`file` or `text`, `split`, `png`, `svg`, ...) returns the zip; `GET /api/info` lists packages and limits.

TeX packages: ams, amscd, bbox, boldsymbol, braket, bussproofs, cancel, cases, centernot, color, colortbl, empheq,
enclose, extpfeil, gensymb, mathtools, mhchem, newcommand, physics, textcomp, textmacros, unicode, units, upgreek, verb.
`\require{...}` of these is accepted; any other package is refused (it would need the network).

Limits: 256 KB and 400 nesting levels per formula, 10,000 macro expansions, 5,000 formulas / 8 MB per batch, PNGs up to
64 megapixels (scale 0.25–16). The server gives each formula 10 s (30 s above 64 KB) in a killable worker process, runs two at a time and
answers 503 when 16 more are waiting.
Speech is a separate optional step: at most 2,048 source characters, 16,384 MathML characters and 256 tree nodes.
Larger expressions still render and carry an explicit speech-omission notice in JSON, the SVG description, the UI,
CLI stderr, file-response `X-Render-Warnings`, and batch manifests. Supply your own alt text when speech is omitted.
Above 16,384 source characters, embedded glyph reuse is enabled automatically and reported in `warnings`; the image
remains standalone. Code previews show at most 1 MB; copy and download retain the complete result.

## Engine

[MathJax 4.1.3](https://github.com/mathjax/MathJax-src) (Apache-2.0) in its direct Node mode with the lite DOM: the
reference implementation of TeX math on the web, with the New Computer Modern font, so output matches what MathJax shows
in browsers (the original 162-formula corpus now verifies 161 supported SVGs byte for byte against stock MathJax and
one explicit tagged-equation refusal; multline uses automatic width). Every lazily loaded font range and named MathML entity table is bundled
and loaded up front, so the executable never reads files or the network. Speech text: the
[Speech Rule Engine 5](https://github.com/Speech-Rule-Engine/speech-rule-engine) (Apache-2.0, English, ClearSpeak).
PNG: [resvg](https://github.com/RazrFalcon/resvg) via resvg-wasm (MPL-2.0). Bun compiles it all into one executable.

Exports are standalone: MathJax's `data-*` attributes are removed, table rules carry their own stroke (MathJax
normally styles them with page CSS), `aria-label` holds the speech text, mhchem's private-use arrows become standard
Unicode arrows in MathML. Glyph ids with `--font-cache local` are numbered per formula, so batch SVGs can share a page.
MathJax's [Safe extension](https://docs.mathjax.org/en/v4.0/options/safe.html), with URLs/IDs disabled and a MathML
attribute allowlist, removes event handlers, external images, links and URL-bearing styles before SVG and MathML
generation. Document types and custom entity declarations are refused; standard named and numeric entities work offline.

Cut: CHTML output (needs MathJax's web fonts and CSS on the page), the `global` font cache (needs a host page),
speech in languages other than English, `\href`/`html` and other packages that link out, and MathJax's inline line
breaking (each formula is one image). Characters outside the MathJax fonts (e.g. CJK in `\text{}`) are drawn by the
viewer's fonts in SVG and are missing from PNGs. ClearSpeak reads some chemistry oddly (`\ce{C}` as "Celsius").
Tagged/numbered equations (`\tag`, MathML `mlabeledtr`) are explicitly refused in CLI/API/UI/batch exports: MathJax's
page-width label positioning has no reliable intrinsic standalone geometry. Remove `\tag` or use unnumbered
`align*`/`equation*`. Untagged `multline` exports use their content width rather than 160 ex of page whitespace.

## Update / uninstall

`localtools-latex-to-svg update` and `localtools-latex-to-svg uninstall` (package-manager installs print the brew/scoop
command instead).

## License

MIT. Third-party licenses: THIRD_PARTY_NOTICES.md.
