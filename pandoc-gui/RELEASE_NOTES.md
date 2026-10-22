# Pandoc GUI release notes

## 1.0.0 (2026-10-19)

First real release: local UI, CLI and file API; document/folder/ZIP input, 34 readers and 19 writers, embedded local images, offline reveal.js slides, citations and reference styles. Bundled Pandoc 3.12.1 and Typst 0.15.1. Sandboxed reads, two conversion slots, deadlines, disconnect and parent-death cleanup. No PDF/DOC input, OCR, remote fetching, arbitrary filters/templates or pixel-perfect office layout. Pandoc GPL source and license offer are included.

## 1.0.1 (2026-10-19)

Review fixes: document csl/bibliography/citation-abbreviations metadata ignored (no file or network reads outside the sandbox); DOCX/ODT/PPTX images embedded once with real alt text; RST/LaTeX/Org/HTML titles and docinfo kept; busy 503 delivered to clients that send a full body first; text outputs keep image paths; errors name user files, no temp paths.

## 1.0.2 (2026-10-19)

Round-2 fixes: citations always use an explicit job-folder style (uploaded CSL or bundled Chicago author-date); document csl/citation-style/citation-abbreviations/bibliography metadata ignored; dependent CSL parents matched by id among uploaded/bundled styles only, never fetched; text writers keep RST titles/docinfo (output matches pandoc defaults); --csl repeatable.

## 1.0.3 (2026-10-22)

Minor fixes: a .zip with exactly 2000 files is accepted; refused uploads are drained (bounded) before the JSON error so send-all/chunked clients get it instead of a reset. Bundles unmodified Pandoc 3.12.1 (source attached) and Typst 0.15.1.
