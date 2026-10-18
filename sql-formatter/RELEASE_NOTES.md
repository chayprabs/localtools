# SQL Formatter release notes

## 1.0.0 (2026-10-18)

First release: lint, fix and transpile SQL in 28 dialects with sqlfluff 4.4 and sqlglot; local web UI and CLI with JSON/SARIF output.

## 1.0.1 (2026-10-18)

1.0.1: a cancelled run no longer blocks the next one, so the latest SQL is what gets linted, fixed or transpiled. Unsupported placeholders and unknown rules error clearly, in-place writes stay atomic, diffs apply without a final newline, and the Raw templater plus non-ligature code font are in the release.
