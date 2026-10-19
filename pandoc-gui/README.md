# Pandoc GUI

Convert documents between Markdown, DOCX, HTML, EPUB, LaTeX and PDF with pandoc.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/pandoc-gui

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/pandoc-gui/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pandoc-gui/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/pandoc-gui`
(`%USERPROFILE%\.localtools\pandoc-gui` on Windows), puts `localtools-pandoc-gui` on your PATH, adds a Pandoc GUI launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47130.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-pandoc-gui update
localtools-pandoc-gui uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/pandoc-gui/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pandoc-gui/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-pandoc-gui` | `brew upgrade localtools-pandoc-gui` | `brew uninstall localtools-pandoc-gui` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-pandoc-gui` | `scoop update localtools-pandoc-gui` | `scoop uninstall localtools-pandoc-gui` |
| winget (Windows) | `winget install localtools.PandocGui` | `winget upgrade localtools.PandocGui` | `winget uninstall localtools.PandocGui` |

Package-manager installs are updated by that package manager; `localtools-pandoc-gui update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 400 MB of disk
- No account, no internet after install.

## Engine

Pandoc 3.12.1 + Typst 0.15.1 (bundled). Official Pandoc binaries preserve document structure across formats; Typst creates offline PDFs without a TeX distribution.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=pandoc-gui.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
