# Archive Inspector release notes

## 1.0.0 (2026-10-17)

First release: inspect zip/jar/apk/docx/whl, tar(.gz/.bz2/.xz/.zst), gz/bz2/xz/zst, 7z and rar without extracting, nested archives included; safety report for zip bombs (ratio, total size, overlapping entries, quines), path traversal, escaping links and disguised names; preview, SHA-256, download, diff and safe CLI extraction.

## 1.0.1 (2026-10-18)

Review fixes: linear name checks on very deep paths, CP437 zip names and index-based entry addressing, stricter Windows-safe extraction (invalid characters, NUL .txt, CONIN$, COM¹), mixed-script-only homoglyph warnings, self-extracting zips, nameless/empty 7z, empty files rejected, DOS zip times without a zone.
