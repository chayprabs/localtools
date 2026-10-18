# Excel Diff

Compare two Excel or CSV files cell by cell: values, formulas, formats, inserted rows and columns, sheets and named ranges.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/excel-diff

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/excel-diff/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/excel-diff/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/excel-diff`
(`%USERPROFILE%\.localtools\excel-diff` on Windows), puts `localtools-excel-diff` on your PATH, adds a Excel Diff launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47109.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-excel-diff update
localtools-excel-diff uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/excel-diff/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/excel-diff/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-excel-diff` | `brew upgrade localtools-excel-diff` | `brew uninstall localtools-excel-diff` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-excel-diff` | `scoop update localtools-excel-diff` | `scoop uninstall localtools-excel-diff` |
| winget (Windows) | `winget install localtools.ExcelDiff` | `winget upgrade localtools.ExcelDiff` | `winget uninstall localtools.ExcelDiff` |

Package-manager installs are updated by that package manager; `localtools-excel-diff update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 25 MB of disk
- No account, no internet after install.

## Engine

Go: streaming xlsx reader + Myers row/column alignment; excelize for the annotated workbook. A streaming reader shows every value exactly as stored (comparison uses the stored double, like Excel) and handles a million cells in seconds; Myers O(ND) alignment, with per-column alignment when a column changed in every row, finds inserted and deleted rows and columns; excelize writes B back with the changes highlighted.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=excel-diff.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
