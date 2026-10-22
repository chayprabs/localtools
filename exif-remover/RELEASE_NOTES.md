# EXIF Remover release notes

## 1.0.0 (2026-10-19)

First release: batch image metadata inspection and removal, original files untouched, orientation/color preservation option, ZIP plus removed/remaining-tags report. JPEG, PNG, TIFF and WebP only. 16 files; 32 MiB each; 64 MiB total. Unix requires Perl 5 on PATH. Not a forensic anonymization guarantee.

## 1.0.1 (2026-10-19)

Privacy fix: removed tags are exported as identifiers only; stripped GPS, author, comment and serial values are no longer copied into ZIP or CLI reports. Inspection and remaining-tag values stay explicit. Batch image metadata inspection/removal, original files untouched, orientation/color preservation option. JPEG, PNG, TIFF and WebP only. 16 files; 32 MiB each; 64 MiB total. Unix requires Perl 5 on PATH. Not a forensic anonymization guarantee.

## 1.0.2 (2026-10-19)

Fixes lossless WebP rejection; TIFF cleaning now removes private IFD0 tags (DocumentName, PageName...) and GeoTIFF location, which counts as location. Quieter warnings, unknown PNG chunks reported, per-file results and privacy highlighting in the UI, HTTP 504 on deadline. Batch image metadata inspection/removal, originals untouched, orientation/color preservation option. JPEG, PNG, TIFF and WebP. 16 files; 32 MiB each; 64 MiB total. Unix requires Perl 5 on PATH. Not a forensic anonymization guarantee.

## 1.0.3 (2026-10-19)

Multi-page TIFF: private and unknown tags removed on every page; warnings deduplicated and capped; per-file report read from the ZIP (no oversized headers); mismatched extensions cleaned as the detected type. Batch image metadata inspection/removal, originals untouched, orientation/color preservation option. JPEG, PNG, TIFF and WebP. 16 files; 32 MiB each; 64 MiB total. Unix requires Perl 5 on PATH. Not a forensic anonymization guarantee.

## 1.0.4 (2026-10-22)

Fixes: unknown private PNG chunks that ExifTool cannot read are now removed when ancillary (unknown critical chunks are kept and warned, since removing them would break the image). The CLI now checks the detected-type output name for collisions before writing. Runtime re-synced (403 rejections drain the body). ExifTool 13.59 unchanged (source attached); Windows bundles Strawberry Perl, macOS/Linux need Perl 5.
