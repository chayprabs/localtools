# PDF to Markdown

Convert PDFs to clean Markdown and JSONL chunks for RAG, keeping tables and reading order.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/pdf-to-markdown

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-to-markdown/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-to-markdown/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/pdf-to-markdown`
(`%USERPROFILE%\.localtools\pdf-to-markdown` on Windows), puts `localtools-pdf-to-markdown` on your PATH, adds a PDF to Markdown launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47104.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-pdf-to-markdown update
localtools-pdf-to-markdown uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-to-markdown/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-to-markdown/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| PyPI | `pipx install localtools-pdf-to-markdown` (or `uv tool install localtools-pdf-to-markdown`) | `pipx upgrade localtools-pdf-to-markdown` | `pipx uninstall localtools-pdf-to-markdown` |

Package-manager installs are updated by that package manager; `localtools-pdf-to-markdown update` is for script installs.

## Requirements

- Windows 10/11, macOS 13+, Linux (glibc), x64 and Apple Silicon
- About 150 MB of disk
- No account, no internet after install.

## Engine

Python + PDFium (pypdfium2 5.14) text/fonts/links/paths/images + own layout analysis and pdfplumber-derived ruled-table finder. PDFium parses 10-40x faster than pdfminer and repairs broken PDFs; docling needs PyTorch and model weights (gigabytes), too heavy for an offline portable tool.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=pdf-to-markdown.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
