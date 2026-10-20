# PDF to Markdown release notes

## 1.0.0 (2026-10-20)

First release: PDF to clean Markdown and JSONL chunks offline. Column-aware reading order, headings, lists, code blocks, links, footnotes, ruled and rule-bounded tables, header/footer removal, hyphenation and ligature repair, page ranges, optional images. No OCR.

## 1.0.1 (2026-10-20)

Fixes from review: paragraphs continued across pages now cite every page in their chunks; downloads work for non-ASCII file names (RFC 5987 filename*); sideways text on a normal page (margin stamps, rotated labels) is kept as its own paragraph instead of dropped; right-to-left lines (Arabic, Hebrew) read in logical order; heading-sized lines at page tops (e.g. 'Exercise 1'...'Exercise 4') are no longer removed as running heads; an early rejected form field drains the upload so the JSON error reaches the client; the UI keeps Convert disabled after the file is removed during a conversion and ignores errors from a replaced file. macOS 13+ is required (pypdfium2 wheels).
