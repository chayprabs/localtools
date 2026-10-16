# CSV JSON Transform

Convert and transform CSV, TSV, JSON and JSONL with Miller verbs: filter, sort, join, reshape.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/csv-json-transform

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/csv-json-transform/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/csv-json-transform/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/csv-json-transform`
(`%USERPROFILE%\.localtools\csv-json-transform` on Windows), puts `localtools-csv-json-transform` on your PATH, adds a CSV JSON Transform launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47106.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-csv-json-transform update
localtools-csv-json-transform uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/csv-json-transform/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/csv-json-transform/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-csv-json-transform` | `brew upgrade localtools-csv-json-transform` | `brew uninstall localtools-csv-json-transform` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-csv-json-transform` | `scoop update localtools-csv-json-transform` | `scoop uninstall localtools-csv-json-transform` |
| winget (Windows) | `winget install localtools.CsvJsonTransform` | `winget upgrade localtools.CsvJsonTransform` | `winget uninstall localtools.CsvJsonTransform` |

Package-manager installs are updated by that package manager; `localtools-csv-json-transform update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 30 MB of disk
- No account, no internet after install.

## Engine

Go + Miller 6.22 (embedded library). Miller 6 is pure Go, embeddable, and its verbs (filter, sort, join, reshape) are already well known.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=csv-json-transform.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
