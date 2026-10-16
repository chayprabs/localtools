# File Type Detector release notes

## 1.0.0 (2026-10-16)

First release: real file types from magic bytes, extension mismatches, disguised executables and scripts, Office VBA macros (OOXML and legacy OLE), polyglots, double extensions and right-to-left-override names. One-page UI with JSON/CSV export; `scan` CLI with --json/--csv and --fail-on for CI.

## 1.0.1 (2026-10-16)

Risk only for formats the OS runs on double-click (archived .py/.sh/.bin/.o are info); padded double extensions flagged; MZ files need a real PE header; corrupt or truncated ZIP/OLE containers warned; uploads batched 500 per request; tables scroll on narrow screens; failed updates keep the old install; package-manager installs print the brew/scoop/winget command for update/uninstall.
