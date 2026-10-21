# EPUB Validator release notes

## 1.0.0 (2026-10-21)

First release: EPUBCheck 5.4.0 validation (profiles, 11 message languages, accessibility metadata summary) and a conservative, fully listed repair pass with before/after re-validation; batch checks, JSON/HTML reports, CLI.

## 1.0.1 (2026-10-21)

Repair never changes declared-entity documents, expands self-closing metadata/manifest, refuses books without them cleanly, matches hrefs like EPUBCheck and never keeps a repair that adds errors; repaired downloads stay for their full 30 minutes. Gated on EPUBCheck's 394 test fixtures.
