# CSV JSON Transform release notes

## 1.0.0 (2026-10-16)

First release: Miller 6.22 verb chains over CSV/TSV/JSON/JSONL/Markdown, local UI, CLI and API; streams large files; line/column syntax errors.

## 1.0.1 (2026-10-17)

Pasted text over 1 MiB no longer truncated; web UI refuses file writes; 120 s timeout + Cancel; child processes die with the server; file remove buttons; trailing blank lines ignored.

## 1.0.2 (2026-10-17)

Security fix: verb chain validated with Miller's own parser; all DSL redirects, main flags in put/filter and --prepipe refused in the web UI/API.

## 1.0.3 (2026-10-21)

Preserve exact unsafe integers in JSON/JSONL previews, bound HTTP transforms to two concurrent workers with clear 503 overload errors, and consistently default CLI run output to JSON. Includes current UI code-font fixes.
