# Postgres Migration Checker release notes

## 1.0.0 (2026-10-18)

First release: offline PostgreSQL migration checks for the lock each statement takes, what it blocks, scans and rewrites, and a safer rewrite. Local UI and CLI with JSON, Markdown and SARIF. Intel macOS PyPI installs use the bundled MacIntel postgast 0.2.0 wheel attached to this release; the ZIP already includes the parser.

## 1.0.1 (2026-10-18)

macOS checks no longer abort when the system refuses a 512 MiB virtual-memory cap. Linux and Windows still enforce that cap. Parser and rules are unchanged from 1.0.0.

## 1.0.2 (2026-10-18)

Safer CHECK and foreign-key SQL keeps quotes on reserved constraint names. A binary-coercible ALTER TYPE is no longer reported as a definite heap rewrite, so the default fail-on high does not fail it. The SQL box shows operators without ligatures. Markdown headings use a middle dot.

## 1.0.3 (2026-10-18)

CREATE TABLE IF NOT EXISTS no longer hides later heavy DDL on a table that may already exist. ALTER TYPE follows the full binary-coercible cast set (text to varchar, xml to text, int4/oid, wider precision); timestamp to timestamptz is flagged as UTC-only. SET (user_catalog_table) takes ACCESS EXCLUSIVE. Flyway files with only non-transactional statements run without a transaction. Placeholder snippets are commented out. UI: unclipped transaction select, padded results.

## 1.0.4 (2026-10-22)

No false rewrite findings for timestamp/time to precision 6, dropped interval field restrictions or array element relabels (varchar[] to text[]); browser disconnects no longer print a traceback; reproducible Intel macOS build.
