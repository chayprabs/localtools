# SVG Optimizer

Optimize and minify SVG files with SVGO and export them to PNG.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/svg-optimizer

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/svg-optimizer/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/svg-optimizer/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/svg-optimizer`
(`%USERPROFILE%\.localtools\svg-optimizer` on Windows), puts `localtools-svg-optimizer` on your PATH, adds a SVG Optimizer launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47127.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-svg-optimizer update
localtools-svg-optimizer uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/svg-optimizer/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/svg-optimizer/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-svg-optimizer` | `brew upgrade localtools-svg-optimizer` | `brew uninstall localtools-svg-optimizer` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-svg-optimizer` | `scoop update localtools-svg-optimizer` | `scoop uninstall localtools-svg-optimizer` |
| winget (Windows) | `winget install localtools.SvgOptimizer` | `winget upgrade localtools.SvgOptimizer` | `winget uninstall localtools.SvgOptimizer` |
| npm | `npm i -g localtools-svg-optimizer` | `npm i -g localtools-svg-optimizer@latest` | `npm rm -g localtools-svg-optimizer` |

Package-manager installs are updated by that package manager; `localtools-svg-optimizer update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 150 MB of disk
- No account, no internet after install.

## Engine

SVGO 4.1 + allowlist sanitizer (SVGO plugin) + resvg (wasm) for PNG. SVGO is the standard SVG optimizer; resvg-wasm renders PNG accurately without a browser on every OS/arch from one artifact; the sanitizer is a strict allowlist tested against 30 XSS payloads in a live browser.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=svg-optimizer.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
