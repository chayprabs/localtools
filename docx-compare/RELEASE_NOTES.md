# DOCX Compare release notes

## 1.0.0 (2026-10-21)

First release: redline .docx with tracked changes (author/date), inline preview, change list, ignore case, accept/reject all tracked changes, CLI and HTTP API.

## 1.0.1 (2026-10-21)

Headers and footers are compared and redlined (or reported); hyperlinks, bookmarks and page setup are kept in the redline; bodies ending in a table compare; malformed uploads get 400; the accept/reject file can be removed.

## 1.0.2 (2026-10-21)

Footnote/endnote links and bookmarks kept; header/footer image, link and field changes and new headers/footers tracked with their images and links; reject-all restores exact link/bookmark ranges.

## 1.0.3 (2026-10-21)

Multi-section documents keep sections and headers/footers; accept/reject handle tracked moves and altChunk; exact reject ranges for bookmarks ending after their paragraph; 413 for oversized uploads; no false header/footer changes; one-line CLI errors.
