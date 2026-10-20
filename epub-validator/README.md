# EPUB Validator

Validate EPUB files with EPUBCheck and repair common errors.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/epub-validator

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/epub-validator/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/epub-validator/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/epub-validator`
(`%USERPROFILE%\.localtools\epub-validator` on Windows), puts `localtools-epub-validator` on your PATH, adds a EPUB Validator launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47136.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-epub-validator update
localtools-epub-validator uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/epub-validator/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/epub-validator/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-epub-validator` | `brew upgrade localtools-epub-validator` | `brew uninstall localtools-epub-validator` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-epub-validator` | `scoop update localtools-epub-validator` | `scoop uninstall localtools-epub-validator` |
| winget (Windows) | `winget install localtools.EpubValidator` | `winget upgrade localtools.EpubValidator` | `winget uninstall localtools.EpubValidator` |

Package-manager installs are updated by that package manager; `localtools-epub-validator update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 200 MB of disk
- No account, no internet after install.

## Engine

EPUBCheck 5.4.0 + jlink'd Temurin 21 runtime + own repair pass. EPUBCheck is the W3C's official EPUB conformance checker; a trimmed bundled Java runtime means no Java install.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=epub-validator.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
