# SQL Formatter

Format and lint SQL in any major dialect with sqlfluff, including auto-fix.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/sql-formatter

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/sql-formatter/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/sql-formatter/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/sql-formatter`
(`%USERPROFILE%\.localtools\sql-formatter` on Windows), puts `localtools-sql-formatter` on your PATH, adds a SQL Formatter launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47117.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-sql-formatter update
localtools-sql-formatter uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/sql-formatter/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/sql-formatter/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| PyPI | `pipx install localtools-sql-formatter` (or `uv tool install localtools-sql-formatter`) | `pipx upgrade localtools-sql-formatter` | `pipx uninstall localtools-sql-formatter` |

Package-manager installs are updated by that package manager; `localtools-sql-formatter update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 120 MB of disk
- No account, no internet after install.

## Engine

sqlfluff 4 (+ sqlfluffrs) and sqlglot. sqlfluff is the most complete open-source SQL linter with real auto-fix across dialects; sqlglot adds dialect-to-dialect transpiling, which sqlfluff cannot do.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=sql-formatter.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
