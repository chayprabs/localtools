# LaTeX to SVG release notes

## 1.0.0 (2026-10-20)

First release: LaTeX, MathML or AsciiMath to standalone SVG, PNG and MathML with speech text, offline with MathJax 4.1.3. Live preview, copy as SVG/MathML/data URI/<img>, batch of .tex/.md files to a zip with a manifest, CLI and HTTP API; killable workers with per-formula deadlines and macro-bomb/nesting limits.

## 1.0.1 (2026-10-20)

Sanitize SVG/MathML/batch exports, bundle named MathML entities, parse multiline macros, skip Markdown code, report macro positions, and compact multline geometry. Tagged equations are explicitly refused. Speech has a separate budget with notices; actual 256 KB formulas use automatic glyph reuse and a bounded longer deadline.

## 1.0.2 (2026-10-20)

Warm workers no longer hang after switching input type or glyph mode (every font range is set up for every MathJax document). .tex batches follow LaTeX rules by extension, Markdown by .md or markers. Colour attributes accept colour tokens only; MathJax internal errors become human messages; \newcommand* accepted.
