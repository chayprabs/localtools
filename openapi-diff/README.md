# OpenAPI Diff

Diff two OpenAPI 3 or Swagger specs and list breaking changes with severity.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/openapi-diff

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/openapi-diff/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/openapi-diff/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/openapi-diff`
(`%USERPROFILE%\.localtools\openapi-diff` on Windows), puts `localtools-openapi-diff` on your PATH, adds a OpenAPI Diff launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47111.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-openapi-diff update
localtools-openapi-diff uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/openapi-diff/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/openapi-diff/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-openapi-diff` | `brew upgrade localtools-openapi-diff` | `brew uninstall localtools-openapi-diff` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-openapi-diff` | `scoop update localtools-openapi-diff` | `scoop uninstall localtools-openapi-diff` |
| winget (Windows) | `winget install localtools.OpenapiDiff` | `winget upgrade localtools.OpenapiDiff` | `winget uninstall localtools.OpenapiDiff` |

Package-manager installs are updated by that package manager; `localtools-openapi-diff update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 30 MB of disk
- No account, no internet after install.

## Engine

Go + oasdiff. oasdiff has the most complete OpenAPI breaking-change rule set and is a Go library.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=openapi-diff.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
