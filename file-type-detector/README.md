# File Type Detector

Detect real file types from magic bytes and flag extension/MIME mismatches, macros and polyglot files across folders.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/file-type-detector

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/file-type-detector/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/file-type-detector/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/file-type-detector`
(`%USERPROFILE%\.localtools\file-type-detector` on Windows), puts `localtools-file-type-detector` on your PATH, adds a File Type Detector launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47101.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-file-type-detector update
localtools-file-type-detector uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/file-type-detector/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/file-type-detector/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-file-type-detector` | `brew upgrade localtools-file-type-detector` | `brew uninstall localtools-file-type-detector` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-file-type-detector` | `scoop update localtools-file-type-detector` | `scoop uninstall localtools-file-type-detector` |
| winget (Windows) | `winget install localtools.FileTypeDetector` | `winget upgrade localtools.FileTypeDetector` | `winget uninstall localtools.FileTypeDetector` |

Package-manager installs are updated by that package manager; `localtools-file-type-detector update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 25 MB of disk
- No account, no internet after install.

## Engine

Go + gabriel-vasile/mimetype + own ZIP/OLE2 container, polyglot and file-name checks. Pure-Go magic-byte detection for ~200 formats in one static binary: no libmagic, no ONNX runtime (Magika was evaluated and rejected for that reason).

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=file-type-detector.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
