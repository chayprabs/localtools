# HTML Extractor release notes

## 1.0.0 (2026-10-17)

First release: extract repeated HTML rows with a row selector and an ordered field map (text or attributes) into JSON or CSV, from the UI, CLI or local API. HTML5 repair, saved-page encodings, bounded input and execution time.

## 1.0.1 (2026-10-17)

Single-column CSV keeps rows with an empty value; selectors match Chromium (:empty, case-insensitive enumerated attribute values, no <template> contents, case-insensitive attribute names); late and ISO-2022-JP meta charsets honoured; unterminated field maps report line/column; oversize requests return 413.
