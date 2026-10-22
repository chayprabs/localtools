# PDF Diff release notes

## 1.0.0 (2026-10-18)

First release: visual pixel diff with highlights (side by side, diff overlay, slider) and per-page scores, word diff highlighted on the page images, metadata/structure diff (info, XMP, fonts, annotations, form fields, bookmarks, attachments), encrypted PDFs, inserted/removed pages paired by content, report PDF / PNG ZIP / JSON exports, CLI with diff-style exit codes.

## 1.0.1 (2026-10-18)

PDFium 8076 (pypdfium2 5.14.0) replaces PDFium 6462, which had later memory-safety CVEs. Scanned PDFs with inserted or removed pages now pair quickly: each thumbnail is rendered once and unchanged pages anchor the pairing. Visual diff is faster. The render budget is now the measured 100 megapixels per PDF. Damaged pages and unusable page sizes get clear errors, out-of-memory is reported as the memory budget, and the word-change list shows operators without ligatures.

## 1.0.2 (2026-10-22)

Structure mode ignores font subset tags, so re-subset fonts are no longer reported as changes; macOS 13 minimum and slow-page timeout documented.
