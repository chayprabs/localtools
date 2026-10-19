# AsciiDoc Converter

Convert AsciiDoc documents and projects to self-contained HTML5, DocBook 5 or Markdown with Asciidoctor, offline.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/asciidoc-converter

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/asciidoc-converter/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/asciidoc-converter/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/asciidoc-converter`
(`%USERPROFILE%\.localtools\asciidoc-converter` on Windows), puts `localtools-asciidoc-converter` on your PATH, adds a AsciiDoc Converter launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47132.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-asciidoc-converter update
localtools-asciidoc-converter uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/asciidoc-converter/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/asciidoc-converter/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-asciidoc-converter` | `brew upgrade localtools-asciidoc-converter` | `brew uninstall localtools-asciidoc-converter` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-asciidoc-converter` | `scoop update localtools-asciidoc-converter` | `scoop uninstall localtools-asciidoc-converter` |
| winget (Windows) | `winget install localtools.AsciidocConverter` | `winget upgrade localtools.AsciidocConverter` | `winget uninstall localtools.AsciidocConverter` |

Package-manager installs are updated by that package manager; `localtools-asciidoc-converter update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 100 MB of disk
- No account, no internet after install.

## Engine

Asciidoctor.js 4.1.1 + downdoc 1.1 + highlight.js 11.12 + MathJax 3.2. Asciidoctor.js is the official JavaScript Asciidoctor; output is byte-identical to using it directly. It runs in SAFE mode jailed to the project, with highlighting, icons and math embedded so nothing is fetched. downdoc (by Asciidoctor's lead) produces Markdown after Asciidoctor resolves includes.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=asciidoc-converter.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
