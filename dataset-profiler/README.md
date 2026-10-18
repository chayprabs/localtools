# Dataset Profiler

Profile CSV, Parquet and JSON datasets (types, nulls, distributions) and detect schema and value drift between two files.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/dataset-profiler

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/dataset-profiler/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/dataset-profiler/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/dataset-profiler`
(`%USERPROFILE%\.localtools\dataset-profiler` on Windows), puts `localtools-dataset-profiler` on your PATH, adds a Dataset Profiler launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47107.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-dataset-profiler update
localtools-dataset-profiler uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/dataset-profiler/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/dataset-profiler/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-dataset-profiler` | `brew upgrade localtools-dataset-profiler` | `brew uninstall localtools-dataset-profiler` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-dataset-profiler` | `scoop update localtools-dataset-profiler` | `scoop uninstall localtools-dataset-profiler` |
| winget (Windows) | `winget install localtools.DatasetProfiler` | `winget upgrade localtools.DatasetProfiler` | `winget uninstall localtools.DatasetProfiler` |

Package-manager installs are updated by that package manager; `localtools-dataset-profiler update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 120 MB of disk
- No account, no internet after install.

## Engine

DuckDB 1.5.6 (official CLI, bundled): SUMMARIZE plus exact SQL counts, histograms, patterns and drift. DuckDB reads CSV, JSON and Parquet natively with full-file type inference and profiles millions of rows in seconds. The official CLI runs as a sandboxed sidecar, so the tool works offline on every OS without cgo.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=dataset-profiler.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
