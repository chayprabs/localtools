# DOCX Compare release notes

## 1.0.0 (2026-10-21)

First release: redline .docx with tracked changes (author/date), inline preview, change list, ignore case, accept/reject all tracked changes, CLI and HTTP API.

## 1.0.1 (2026-10-21)

Headers and footers are compared and redlined (or reported); hyperlinks, bookmarks and page setup are kept in the redline; bodies ending in a table compare; malformed uploads get 400; the accept/reject file can be removed.

## 1.0.2 (2026-10-21)

Footnote/endnote links and bookmarks kept; header/footer image, link and field changes and new headers/footers tracked with their images and links; reject-all restores exact link/bookmark ranges.
