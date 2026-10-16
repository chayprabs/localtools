# PDF Toolkit

Merge, split, reorder, rotate, compress, stamp, number, encrypt and fill PDF forms, offline.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/pdf-toolkit

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-toolkit/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-toolkit/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/pdf-toolkit`
(`%USERPROFILE%\.localtools\pdf-toolkit` on Windows), puts `localtools-pdf-toolkit` on your PATH, adds a PDF Toolkit launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47102.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-pdf-toolkit update
localtools-pdf-toolkit uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-toolkit/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-toolkit/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-pdf-toolkit` | `brew upgrade localtools-pdf-toolkit` | `brew uninstall localtools-pdf-toolkit` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-pdf-toolkit` | `scoop update localtools-pdf-toolkit` | `scoop uninstall localtools-pdf-toolkit` |
| winget (Windows) | `winget install localtools.PdfToolkit` | `winget upgrade localtools.PdfToolkit` | `winget uninstall localtools.PdfToolkit` |

Package-manager installs are updated by that package manager; `localtools-pdf-toolkit update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 30 MB of disk
- No account, no internet after install.

## Engine

Go + pdfcpu, plus own image recompression, form flattening and XFDF/FDF import. pdfcpu is a pure-Go PDF library covering merge, split, pages, rotate, optimize, stamps, AES-256 and AcroForm fill in one static binary; no Ghostscript, qpdf or Java.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=pdf-toolkit.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
