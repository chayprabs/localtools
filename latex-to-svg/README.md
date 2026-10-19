# LaTeX to SVG

Render LaTeX, MathML or AsciiMath to SVG, PNG and MathML with speech alt text, offline with MathJax.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/latex-to-svg

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/latex-to-svg/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/latex-to-svg/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/latex-to-svg`
(`%USERPROFILE%\.localtools\latex-to-svg` on Windows), puts `localtools-latex-to-svg` on your PATH, adds a LaTeX to SVG launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47133.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-latex-to-svg update
localtools-latex-to-svg uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/latex-to-svg/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/latex-to-svg/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-latex-to-svg` | `brew upgrade localtools-latex-to-svg` | `brew uninstall localtools-latex-to-svg` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-latex-to-svg` | `scoop update localtools-latex-to-svg` | `scoop uninstall localtools-latex-to-svg` |
| winget (Windows) | `winget install localtools.LatexToSvg` | `winget upgrade localtools.LatexToSvg` | `winget uninstall localtools.LatexToSvg` |

Package-manager installs are updated by that package manager; `localtools-latex-to-svg update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 100 MB of disk
- No account, no internet after install.

## Engine

MathJax 4.1.3 (TeX/MathML/AsciiMath -> SVG/MathML) + Speech Rule Engine 5 + resvg-wasm 2.6. MathJax is the reference renderer of TeX math on the web; run directly with its lite DOM and every font range bundled, it renders offline and byte-identical to stock MathJax. SRE gives accessible speech text, resvg rasterizes PNGs identically on every OS.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=latex-to-svg.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
