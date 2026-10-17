# Archive Inspector

List and inspect nested zip, tar, 7z, rar, gz, xz and zst archives and flag zip bombs and path traversal.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/archive-inspector

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/archive-inspector/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/archive-inspector/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/archive-inspector`
(`%USERPROFILE%\.localtools\archive-inspector` on Windows), puts `localtools-archive-inspector` on your PATH, adds a Archive Inspector launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47122.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-archive-inspector update
localtools-archive-inspector uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/archive-inspector/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/archive-inspector/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-archive-inspector` | `brew upgrade localtools-archive-inspector` | `brew uninstall localtools-archive-inspector` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-archive-inspector` | `scoop update localtools-archive-inspector` | `scoop uninstall localtools-archive-inspector` |
| winget (Windows) | `winget install localtools.ArchiveInspector` | `winget upgrade localtools.ArchiveInspector` | `winget uninstall localtools.ArchiveInspector` |

Package-manager installs are updated by that package manager; `localtools-archive-inspector update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 25 MB of disk
- No account, no internet after install.

## Engine

Go + mholt/archives (bodgit/sevenzip, nwaples/rardecode). Pure Go: one static binary reads zip/tar/7z/rar and every compression layer through one streaming API, with direct zip offsets for overlap-bomb detection; no cgo libarchive or bundled 7-Zip.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=archive-inspector.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
