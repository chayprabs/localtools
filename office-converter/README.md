# Office Converter

Convert PPTX, DOCX, XLSX and ODF documents to PDF or PNG with LibreOffice, including speaker notes.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/office-converter

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/office-converter/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/office-converter/install.sh | bash
```

The installer checks that Docker is running, pulls the image, installs to `~/.localtools/office-converter`
(`%USERPROFILE%\.localtools\office-converter` on Windows), puts `localtools-office-converter` on your PATH, adds a Office Converter launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47135.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-office-converter update
localtools-office-converter uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/office-converter/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/office-converter/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Docker | `docker run --rm -p 127.0.0.1:47135:47135 ghcr.io/chayprabs/localtools-office-converter:latest` | `docker pull ghcr.io/chayprabs/localtools-office-converter:latest` | `docker rmi ghcr.io/chayprabs/localtools-office-converter` |

Package-manager installs are updated by that package manager; `localtools-office-converter update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc)
- About 1500 MB of disk
- Docker (Docker Desktop on Windows/macOS) with Linux containers
- No account, no internet after install.

## Engine

LibreOffice 25.2.3 (Debian 4:25.2.3-2+deb13u8) + Poppler 25.03.0 (25.03.0-5+deb13u4). LibreOffice renders real DOCX/PPTX/XLSX and ODF with bundled fonts; Poppler rasterizes every PDF page. Both base image manifests and Debian snapshot 20261020T000000Z are pinned for fixed dependency inputs. The isolated Docker image keeps this large engine consistent across hosts. Requires Landlock ABI3+ in the Linux kernel; external links/macros/active content are rejected. Pin updates require a new tested patch.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=office-converter.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
