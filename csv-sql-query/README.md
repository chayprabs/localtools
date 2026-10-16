# CSV SQL Query

Run SQL on CSV, TSV, JSON, Parquet and log files (nginx, Apache, syslog) with DuckDB.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/csv-sql-query

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/csv-sql-query/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/csv-sql-query/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/csv-sql-query`
(`%USERPROFILE%\.localtools\csv-sql-query` on Windows), puts `localtools-csv-sql-query` on your PATH, adds a CSV SQL Query launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47105.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-csv-sql-query update
localtools-csv-sql-query uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/csv-sql-query/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/csv-sql-query/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-csv-sql-query` | `brew upgrade localtools-csv-sql-query` | `brew uninstall localtools-csv-sql-query` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-csv-sql-query` | `scoop update localtools-csv-sql-query` | `scoop uninstall localtools-csv-sql-query` |
| winget (Windows) | `winget install localtools.CsvSqlQuery` | `winget upgrade localtools.CsvSqlQuery` | `winget uninstall localtools.CsvSqlQuery` |

Package-manager installs are updated by that package manager; `localtools-csv-sql-query update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 200 MB of disk
- No account, no internet after install.

## Engine

DuckDB 1.5.6 (official CLI, bundled) + log parsers (nginx/Apache, syslog RFC 3164/5424). DuckDB queries CSV/Parquet/JSON in place, in parallel and out of core: a 1 GB CSV aggregates in about 1-2 s. The official CLI is bundled with the excel and sqlite extensions, so it works offline on every OS without cgo.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=csv-sql-query.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
