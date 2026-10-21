# File Type Detector release notes

## 1.0.0 (2026-10-16)

First release: real file types from magic bytes, extension mismatches, disguised executables and scripts, Office VBA macros (OOXML and legacy OLE), polyglots, double extensions and right-to-left-override names. One-page UI with JSON/CSV export; `scan` CLI with --json/--csv and --fail-on for CI.

## 1.0.1 (2026-10-16)

Risk only for formats the OS runs on double-click (archived .py/.sh/.bin/.o are info); padded double extensions flagged; MZ files need a real PE header; corrupt or truncated ZIP/OLE containers warned; uploads batched 500 per request; tables scroll on narrow screens; failed updates keep the old install; package-manager installs print the brew/scoop/winget command for update/uninstall.

## 1.0.2 (2026-10-16)

Detects ISO 9660/UDF, DMG, VHD/VHDX, VMDK and QCOW images; archive entries that run on double-click are warn, risk only when disguised or inside an archive posing as another type; text starting with MZ is text; Unicode whitespace padding caught in double extensions; .winmd accepted; EPUB without a mimetype entry detected.

## 1.0.3 (2026-10-21)

Preserve text, JSON and JPEG primary types when PDF headers occur inside content; accept primary PDF headers only at offset zero or after a UTF-8 BOM and line breaks. Report internal PDF signatures as possible-polyglot warnings without claiming validation. Catch U+2800/U+3164 blank padding in loose files and ZIP entries. Refresh shared kit assets, add selected-file removal and clear stale results on changed input.
