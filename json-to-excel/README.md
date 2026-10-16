# JSON to Excel

Convert JSON or JSONL into formatted .xlsx workbooks with typed columns and multiple sheets.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/json-to-excel

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/json-to-excel/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/json-to-excel/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/json-to-excel`
(`%USERPROFILE%\.localtools\json-to-excel` on Windows), puts `localtools-json-to-excel` on your PATH, adds a JSON to Excel launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47108.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-json-to-excel update
localtools-json-to-excel uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/json-to-excel/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/json-to-excel/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-json-to-excel` | `brew upgrade localtools-json-to-excel` | `brew uninstall localtools-json-to-excel` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-json-to-excel` | `scoop update localtools-json-to-excel` | `scoop uninstall localtools-json-to-excel` |
| winget (Windows) | `winget install localtools.JsonToExcel` | `winget upgrade localtools.JsonToExcel` | `winget uninstall localtools.JsonToExcel` |

Package-manager installs are updated by that package manager; `localtools-json-to-excel update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 25 MB of disk
- No account, no internet after install.

## Engine

Go + excelize. excelize is the most complete pure-Go .xlsx writer (styles, tables, conditional formats, charts, streaming): one static binary, no Office or runtime needed.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=json-to-excel.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
