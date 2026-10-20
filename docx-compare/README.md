# DOCX Compare

Compare two Word documents and produce a tracked-changes redline .docx.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/docx-compare

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/docx-compare`
(`%USERPROFILE%\.localtools\docx-compare` on Windows), puts `localtools-docx-compare` on your PATH, adds a DOCX Compare launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47134.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-docx-compare update
localtools-docx-compare uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-docx-compare` | `brew upgrade localtools-docx-compare` | `brew uninstall localtools-docx-compare` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-docx-compare` | `scoop update localtools-docx-compare` | `scoop uninstall localtools-docx-compare` |
| winget (Windows) | `winget install localtools.DocxCompare` | `winget upgrade localtools.DocxCompare` | `winget uninstall localtools.DocxCompare` |

Package-manager installs are updated by that package manager; `localtools-docx-compare update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 120 MB of disk
- No account, no internet after install.

## Engine

.NET 10 self-contained + Clippit (Open-XML-PowerTools) WmlComparer. WmlComparer writes genuine Word tracked changes (w:ins/w:del) at word level, including tables, footnotes and text boxes; accepting the redline gives the revised text and rejecting it gives the original (127/127 test pairs).

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=docx-compare.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
