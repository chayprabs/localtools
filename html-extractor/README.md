# HTML Extractor

Extract data from HTML pages with CSS selectors into JSON or CSV.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/html-extractor
Field map format: [FIELD_MAP.md](FIELD_MAP.md)

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/html-extractor/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/html-extractor/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/html-extractor`
(`%USERPROFILE%\.localtools\html-extractor` on Windows), puts `localtools-html-extractor` on your PATH, adds a HTML Extractor launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47120.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-html-extractor update
localtools-html-extractor uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/html-extractor/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/html-extractor/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-html-extractor` | `brew upgrade localtools-html-extractor` | `brew uninstall localtools-html-extractor` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-html-extractor` | `scoop update localtools-html-extractor` | `scoop uninstall localtools-html-extractor` |
| winget (Windows) | `winget install localtools.HtmlExtractor` | `winget upgrade localtools.HtmlExtractor` | `winget uninstall localtools.HtmlExtractor` |

Package-manager installs are updated by that package manager; `localtools-html-extractor update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 20 MB of disk
- No account, no internet after install.

## Engine

Go + goquery / cascadia. goquery/cascadia give jQuery-style CSS selectors over a real HTML5 parser in pure Go.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=html-extractor.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
