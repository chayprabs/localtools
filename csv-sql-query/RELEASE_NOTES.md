# CSV SQL Query release notes

## 1.0.0 (2026-10-16)

First release: SQL on CSV, TSV, JSON/JSONL, Parquet, XLSX, SQLite/DuckDB files and nginx/Apache/syslog logs, joins across files, paging over any result size, EXPLAIN ANALYZE, CSV/JSON/Parquet/XLSX downloads, CLI query/shell.

## 1.0.1 (2026-10-16)

Fix: on macOS the bundled DuckDB engine was not found when the tool was started through the installed shim.

## 1.0.2 (2026-10-17)

Exact display of integers beyond 2^53; keyword-named tables quoted; JSON-lines logs skip and count non-JSON lines; valid JSON downloads with NaN/Infinity; DuckDB notices shown; Next disabled on the last page.
