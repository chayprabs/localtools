# GitHub Actions Linter

Lint GitHub Actions workflows and composite actions for errors and security issues (script injection, permissions, unpinned actions) with a fix per finding.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/github-actions-linter

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/github-actions-linter/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/github-actions-linter/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/github-actions-linter`
(`%USERPROFILE%\.localtools\github-actions-linter` on Windows), puts `localtools-github-actions-linter` on your PATH, adds a GitHub Actions Linter launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47113.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-github-actions-linter update
localtools-github-actions-linter uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/github-actions-linter/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/github-actions-linter/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-github-actions-linter` | `brew upgrade localtools-github-actions-linter` | `brew uninstall localtools-github-actions-linter` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-github-actions-linter` | `scoop update localtools-github-actions-linter` | `scoop uninstall localtools-github-actions-linter` |
| winget (Windows) | `winget install localtools.GithubActionsLinter` | `winget upgrade localtools.GithubActionsLinter` | `winget uninstall localtools.GithubActionsLinter` |

Package-manager installs are updated by that package manager; `localtools-github-actions-linter update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 60 MB of disk
- No account, no internet after install.

## Engine

Go + actionlint 1.7.12 + zizmor 1.31.1. actionlint validates workflow syntax and expression types with bundled action metadata; the checksum-pinned zizmor sidecar adds dedicated offline security audits. Both engines feed one local report without remote fetching.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=github-actions-linter.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
