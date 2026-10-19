# Typst Editor

Write Typst documents with live preview and export them to PDF, PNG or SVG.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/typst-editor

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/typst-editor/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/typst-editor/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/typst-editor`
(`%USERPROFILE%\.localtools\typst-editor` on Windows), puts `localtools-typst-editor` on your PATH, adds a Typst Editor launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47131.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-typst-editor update
localtools-typst-editor uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/typst-editor/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/typst-editor/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-typst-editor` | `brew upgrade localtools-typst-editor` | `brew uninstall localtools-typst-editor` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-typst-editor` | `scoop update localtools-typst-editor` | `scoop uninstall localtools-typst-editor` |
| winget (Windows) | `winget install localtools.TypstEditor` | `winget upgrade localtools.TypstEditor` | `winget uninstall localtools.TypstEditor` |

Package-manager installs are updated by that package manager; `localtools-typst-editor update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 70 MB of disk
- No account, no internet after install.

## Engine

typst (bundled official binary). The official typst binary compiles in milliseconds and needs nothing else.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=typst-editor.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
