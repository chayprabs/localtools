# PDF Diff

Compare two PDFs page by page with visual pixel-diff overlays and a text diff.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/pdf-diff

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-diff/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-diff/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/pdf-diff`
(`%USERPROFILE%\.localtools\pdf-diff` on Windows), puts `localtools-pdf-diff` on your PATH, adds a PDF Diff launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47103.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-pdf-diff update
localtools-pdf-diff uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-diff/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-diff/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| PyPI | `pipx install localtools-pdf-diff` (or `uv tool install localtools-pdf-diff`) | `pipx upgrade localtools-pdf-diff` | `pipx uninstall localtools-pdf-diff` |

Package-manager installs are updated by that package manager; `localtools-pdf-diff update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 150 MB of disk
- No account, no internet after install.

## Engine

Python + PDFium (pypdfium2) render/text/structure + Pillow pixel diff + difflib word diff. PDFium renders pages exactly like Chrome; numpy pixel diff is exact and fast.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=pdf-diff.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
