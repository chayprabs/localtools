# Typst Editor release notes

## 1.0.0 (2026-10-19)

First release: live preview, clickable diagnostics, PDF/PDF-A/PNG/SVG export, zip projects; bundles typst 0.15.1; never downloads packages.

## 1.0.1 (2026-10-19)

Preserve exact binary, Latin-1 and BOM bytes through preview and project ZIPs; keep binary files across reloads, migrate saved projects, confirm template replacement with Undo, and ship embedded font licenses.

## 1.0.2 (2026-10-22)

Early rejections (two compiles already running, invalid paths, size limit) now read the upload first (up to the 68 MiB request cap, 10 s) and then send the JSON error, so the browser shows the message instead of 'Failed to fetch'. Runtime re-synced. Built with official Typst 0.15.1.
