# PDF Toolkit release notes

## 1.0.0 (2026-10-17)

First release: merge with per-file page ranges, split (every N, ranges, bookmarks), extract/delete/reorder pages, rotate, compress with JPEG re-encoding of photos, text and image stamps, page numbers, AES-256 (revision 6) encrypt/decrypt, metadata, and form list/fill (JSON, XFDF, FDF)/export/flatten.

## 1.0.1 (2026-10-17)

Fixes from an independent review on 45 real-world PDFs: encrypt works on every readable PDF (AES-256 revision 6, or revision 5 when the file cannot meet PDF 2.0 rules, reported in the result); form fill and flatten use the tool's own AcroForm code (any text incl. non-Latin, list boxes, LibreOffice/NeedAppearances forms, IRS forms); merge of files whose /Info points at the page tree; HTTP jobs run in killable worker processes (2 at once, 10 min, 2 GiB, 256 MiB per decoded stream) so bombs fail fast; UI clears stale results and can remove chosen files; one-line human errors; reverse ranges with l (l-1).

## 1.0.2 (2026-10-17)

Fixes clipped Latin form appearances in short LibreOffice widgets; rich-text plain-value fallback and per-cell comb appearances; exact numeric JSON values; ordinary indirect uncompressed FDF; immediate stale UI result/field clearing, async response cancellation/guards, and encrypted-form password retry. Adds independent rendered-ink and comb-geometry regressions. Existing worker isolation and documented non-WinAnsi flattening limits remain.

## 1.0.3 (2026-10-22)

Multiline text fields word-wrap inside the field (auto-size shrinks to fit), flatten keeps stored appearances that already show the value, plain FDF error messages, startup sweep of stale job folders, ligatures off in code text, pdfcpu v0.16.3 security update.

## 1.0.4 (2026-10-22)

Flatten keeps a stored field appearance only when its shown text matches the complete current value; stale, shortened, extended or cleared values and list selections are redrawn.
