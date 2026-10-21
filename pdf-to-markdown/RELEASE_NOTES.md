# PDF to Markdown release notes

## 1.0.0 (2026-10-20)

First release: PDF to clean Markdown and JSONL chunks offline. Column-aware reading order, headings, lists, code blocks, links, footnotes, ruled and rule-bounded tables, header/footer removal, hyphenation and ligature repair, page ranges, optional images. No OCR.

## 1.0.1 (2026-10-20)

Fixes from review: paragraphs continued across pages now cite every page in their chunks; downloads work for non-ASCII file names (RFC 5987 filename*); sideways text on a normal page (margin stamps, rotated labels) is kept as its own paragraph instead of dropped; right-to-left lines (Arabic, Hebrew) read in logical order; heading-sized lines at page tops (e.g. 'Exercise 1'...'Exercise 4') are no longer removed as running heads; an early rejected form field drains the upload so the JSON error reaches the client; the UI keeps Convert disabled after the file is removed during a conversion and ignores errors from a replaced file. macOS 13+ is required (pypdfium2 wheels).

## 1.0.2 (2026-10-21)

Repeated headers and footers are removed again whatever their font size (1.0.1 kept large ones and turned them into headings), while headings at page tops that differ by number ("Exercise 1".."Exercise 4") and body sentences that repeat with different numbers are kept; the summary now lists examples of removed lines. The token estimate is conservative for Chinese, Japanese, Korean and other non-ASCII text and for name lists (never below OpenAI cl100k on the tested corpus). Markdown characters in PDF text are escaped, URLs wrapped across lines are joined, adjacent footnotes stay separate, tall table row-label cells are split per row, and sideways margin text no longer interrupts a paragraph continued on the next page. Requires macOS 13+.

## 1.0.3 (2026-10-22)

Keep the first repeated slide title, table caption or form line and preserve bold chapter labels. Escape literal square brackets, fence code-like monospaced listings, join URLs wrapped after their scheme and improve token estimates for garbled fonts. Remove sideways running footers and join hyphenated small-print footnotes across pages. Distinct image dimensions and color modes no longer collide when pixel bytes match. Verified on 17 real/generated documents, including cl100k chunk bounds. Requires macOS 13+.
