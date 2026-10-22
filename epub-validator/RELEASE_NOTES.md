# EPUB Validator release notes

## 1.0.0 (2026-10-21)

First release: EPUBCheck 5.4.0 validation (profiles, 11 message languages, accessibility metadata summary) and a conservative, fully listed repair pass with before/after re-validation; batch checks, JSON/HTML reports, CLI.

## 1.0.1 (2026-10-21)

Repair never changes declared-entity documents, expands self-closing metadata/manifest, refuses books without them cleanly, matches hrefs like EPUBCheck and never keeps a repair that adds errors; repaired downloads stay for their full 30 minutes. Gated on EPUBCheck's 394 test fixtures.

## 1.0.2 (2026-10-22)

Repair: a package document with both <metadata/> and <manifest/> self-closing now gets both expanded (new manifest items land inside <manifest>). Runtime re-synced. EPUBCheck 5.4.0 on jlink'd Temurin 21.0.12.1+1 unchanged; Java sandbox policy unchanged. Java runtime source: https://github.com/adoptium/jdk21u/tree/jdk-21.0.12.1+1
