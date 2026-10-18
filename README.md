# localtools

Free, offline tools that run on your machine. Each one is a small local app: install it with one command,
it opens in your browser at `http://127.0.0.1:<port>`, and your files never leave your computer.
No account, no upload, no telemetry.

Browse all tools, with docs and how-tos: **https://tools.chaitanyaprabuddha.com**

## Tools

<!-- tools -->
| Tool | What it does | Command |
|---|---|---|
| [File Type Detector](file-type-detector/) | Detect real file types from magic bytes and flag extension/MIME mismatches, macros and polyglot files across folders. | `localtools-file-type-detector` |
| [PDF Toolkit](pdf-toolkit/) | Merge, split, reorder, rotate, compress, stamp, number, encrypt and fill PDF forms, offline. | `localtools-pdf-toolkit` |
| [CSV SQL Query](csv-sql-query/) | Run SQL on CSV, TSV, JSON, Parquet and log files (nginx, Apache, syslog) with DuckDB. | `localtools-csv-sql-query` |
| [CSV JSON Transform](csv-json-transform/) | Convert and transform CSV, TSV, JSON and JSONL with Miller verbs: filter, sort, join, reshape. | `localtools-csv-json-transform` |
| [Dataset Profiler](dataset-profiler/) | Profile CSV, Parquet and JSON datasets (types, nulls, distributions) and detect schema and value drift between two files. | `localtools-dataset-profiler` |
| [JSON to Excel](json-to-excel/) | Convert JSON or JSONL into formatted .xlsx workbooks with typed columns and multiple sheets. | `localtools-json-to-excel` |
| [Excel Diff](excel-diff/) | Compare two Excel or CSV files cell by cell: values, formulas, formats, inserted rows and columns, sheets and named ranges. | `localtools-excel-diff` |
| [YAML JSON Query](yaml-json-query/) | Query and edit YAML, JSON, XML, TOML and INI with yq expressions and apply RFC 6902 JSON Patch, keeping comments. | `localtools-yaml-json-query` |
| [OpenAPI Diff](openapi-diff/) | Diff two OpenAPI 3 or Swagger specs and list breaking changes with severity. | `localtools-openapi-diff` |
| [GitHub Actions Linter](github-actions-linter/) | Lint GitHub Actions workflows and composite actions for errors and security issues (script injection, permissions, unpinned actions) with a fix per finding. | `localtools-github-actions-linter` |
| [Kubernetes Manifest Checker](k8s-manifest-checker/) | Score Kubernetes YAML and Helm-rendered manifests for production readiness and security, with a fix snippet per finding. | `localtools-k8s-manifest-checker` |
| [Terraform Plan Viewer](terraform-plan-viewer/) | Review terraform or OpenTofu plan JSON offline: destructive changes first, attribute diffs, blast radius, drift and risk flags. | `localtools-terraform-plan-viewer` |
| [SQL Formatter](sql-formatter/) | Format and lint SQL in any major dialect with sqlfluff, including auto-fix. | `localtools-sql-formatter` |
| [Grok Debugger](grok-debugger/) | Test grok patterns against log lines with the full Logstash pattern library and highlighted matches. | `localtools-grok-debugger` |
| [HTML Extractor](html-extractor/) | Extract data from HTML pages with CSS selectors into JSON or CSV. | `localtools-html-extractor` |
| [SSL Checker](ssl-checker/) | Check a domain's TLS certificate chain, expiry, supported protocols, DNSSEC and CAA records. | `localtools-ssl-checker` |
| [Archive Inspector](archive-inspector/) | List and inspect nested zip, tar, 7z, rar, gz, xz and zst archives and flag zip bombs and path traversal. | `localtools-archive-inspector` |
| [SVG Optimizer](svg-optimizer/) | Optimize and minify SVG files with SVGO and export them to PNG. | `localtools-svg-optimizer` |
| [Font Subsetter](font-subsetter/) | Subset fonts to the characters you use, instance variable fonts, and convert to WOFF2. | `localtools-font-subsetter` |
<!-- /tools -->

## Install

Every tool has a folder here with its installers. One line, no admin rights:

```powershell
# Windows (PowerShell)
irm https://raw.githubusercontent.com/chayprabs/localtools/main/<tool>/install.ps1 | iex
```

```sh
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/<tool>/install.sh | bash
```

The installer downloads the tool's release zip from this repo's
[Releases](https://github.com/chayprabs/localtools/releases), checks its SHA-256, unpacks it to `~/.localtools/<tool>`,
puts `localtools-<tool>` on your PATH (`~/.localtools/bin`), adds a launcher (Start Menu, `~/Applications`, or your
app menu) and opens the tool. Re-running it updates. `localtools-<tool> update` and `localtools-<tool> uninstall` do
the same from the command line. Set `LOCALTOOLS_NO_OPEN=1` to install without opening the browser.

Package managers, where a tool supports them:
[Homebrew](https://github.com/chayprabs/homebrew-localtools) (`brew install chayprabs/localtools/localtools-<tool>`),
[Scoop](https://github.com/chayprabs/scoop-localtools), winget (`localtools.<Tool>`), npm and PyPI (`localtools-<tool>`),
and Docker images on `ghcr.io/chayprabs/localtools-<tool>`. Each tool's README lists which apply.

Every install is tested from scratch on Windows (PowerShell 5.1), macOS and Ubuntu by the
[clean-install workflow](.github/workflows/clean-install.yml).

## Report an issue

[Open an issue](https://github.com/chayprabs/localtools/issues/new/choose) and pick the tool. Each tool's page also has a
"Report an issue" link.

## License

MIT. Bundled third-party engines keep their own licenses, listed in each install's `THIRD_PARTY_NOTICES.md`.
