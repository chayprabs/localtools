# OG Image Generator release notes

## 1.0.0 (2026-10-19)

First release: 8 templates, OG/X/square/story/custom sizes, PNG/JPEG/SVG, live preview, image and font uploads, CJK/RTL/emoji fallbacks, editable template markup with line:column errors, CSV/JSON batch to zip, CLI render/batch, no network access.

## 1.0.1 (2026-10-19)

WebP images decoded (were blank); Connection: close clients get JSON 413/503; nested sections capped; worker replies framed; code card truncation inside the window; human errors for variable fonts and corrupt images; Excel Windows-1252 and semicolon CSV; template picker locks while edited markup is used; stricter URL checks; accurate notices; pinned Bun 1.4.3 builds.

## 1.0.2 (2026-10-19)

Drain rejected uploads before replying so Connection: close clients receive complete JSON 413/503. Resolve image bytes after template expansion, retaining real 10 MiB/25 MP limits. Validate inline WebP dimensions before decoding, including hidden VP8X bitstreams; cache conversion and compress PNG faster. Include libwebp's BSD-3-Clause copyright/license and clarify server-only deadlines.
