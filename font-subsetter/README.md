# Font Subsetter

Subset fonts to the characters you use, instance variable fonts, and convert to WOFF2.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/font-subsetter

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/font-subsetter/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/font-subsetter/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/font-subsetter`
(`%USERPROFILE%\.localtools\font-subsetter` on Windows), puts `localtools-font-subsetter` on your PATH, adds a Font Subsetter launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47129.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-font-subsetter update
localtools-font-subsetter uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/font-subsetter/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/font-subsetter/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| PyPI | `pipx install localtools-font-subsetter` (or `uv tool install localtools-font-subsetter`) | `pipx upgrade localtools-font-subsetter` | `pipx uninstall localtools-font-subsetter` |

Package-manager installs are updated by that package manager; `localtools-font-subsetter update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 80 MB of disk
- No account, no internet after install.

## Engine

fontTools (pyftsubset, varLib.instancer, WOFF2). fontTools is the reference font library; pyftsubset and instancer are what font engineers use.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=font-subsetter.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
