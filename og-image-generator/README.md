# OG Image Generator

Design and render Open Graph / social card images offline: templates, live preview, code highlighting, batch.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/og-image-generator

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/og-image-generator/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/og-image-generator/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/og-image-generator`
(`%USERPROFILE%\.localtools\og-image-generator` on Windows), puts `localtools-og-image-generator` on your PATH, adds a OG Image Generator launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47128.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-og-image-generator update
localtools-og-image-generator uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/og-image-generator/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/og-image-generator/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-og-image-generator` | `brew upgrade localtools-og-image-generator` | `brew uninstall localtools-og-image-generator` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-og-image-generator` | `scoop update localtools-og-image-generator` | `scoop uninstall localtools-og-image-generator` |
| winget (Windows) | `winget install localtools.OgImageGenerator` | `winget upgrade localtools.OgImageGenerator` | `winget uninstall localtools.OgImageGenerator` |

Package-manager installs are updated by that package manager; `localtools-og-image-generator update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 120 MB of disk
- No account, no internet after install.

## Engine

satori 0.62 + resvg-wasm 2.6 + shiki 4 (Oniguruma). satori lays out HTML/CSS (flex, grid, stylesheets, HarfBuzz shaping) as SVG without a browser; resvg rasterizes it identically on every OS; shiki gives editor-grade code highlighting. All wasm, fonts and emoji are embedded, so nothing is fetched.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=og-image-generator.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
