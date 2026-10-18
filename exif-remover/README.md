# EXIF Remover

Inspect and remove metadata from JPEG, PNG, TIFF and WebP images; download clean copies and a remaining-tags report.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/exif-remover

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/exif-remover/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/exif-remover/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/exif-remover`
(`%USERPROFILE%\.localtools\exif-remover` on Windows), puts `localtools-exif-remover` on your PATH, adds a EXIF Remover launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47126.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-exif-remover update
localtools-exif-remover uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/exif-remover/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/exif-remover/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-exif-remover` | `brew upgrade localtools-exif-remover` | `brew uninstall localtools-exif-remover` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-exif-remover` | `scoop update localtools-exif-remover` | `scoop uninstall localtools-exif-remover` |
| winget (Windows) | `winget install localtools.ExifRemover` | `winget upgrade localtools.ExifRemover` | `winget uninstall localtools.ExifRemover` |

Package-manager installs are updated by that package manager; `localtools-exif-remover update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 55 MB of disk
- No account, no internet after install.

## Engine

Go + bundled ExifTool 13.59 (Unix requires Perl 5). Mature EXIF/GPS/IPTC/XMP/ICC parsers; tested raster formats, verified cleaned outputs, unmodified portable Windows bundle. macOS/Linux require Perl 5 on PATH.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=exif-remover.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
