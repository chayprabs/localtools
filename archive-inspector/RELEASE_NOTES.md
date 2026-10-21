# Archive Inspector release notes

## 1.0.0 (2026-10-17)

First release: inspect zip/jar/apk/docx/whl, tar(.gz/.bz2/.xz/.zst), gz/bz2/xz/zst, 7z and rar without extracting, nested archives included; safety report for zip bombs (ratio, total size, overlapping entries, quines), path traversal, escaping links and disguised names; preview, SHA-256, download, diff and safe CLI extraction.

## 1.0.1 (2026-10-18)

Review fixes: linear name checks on very deep paths, CP437 zip names and index-based entry addressing, stricter Windows-safe extraction (invalid characters, NUL .txt, CONIN$, COM¹), mixed-script-only homoglyph warnings, self-extracting zips, nameless/empty 7z, empty files rejected, DOS zip times without a zone.

## 1.0.2 (2026-10-22)

Safe extract no longer refuses ordinary names such as com12.txt or lpt123.log (only COM1-9/LPT1-9 are devices). Overlong names in nested archives keep their archive path and each gets its own finding. Zip entries with an unset MS-DOS date show no time instead of 1979-11-30. Code text renders without ligatures.
