# GraphQL Diff

Compare two GraphQL schemas and classify breaking, dangerous and safe changes.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/graphql-diff

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/graphql-diff/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/graphql-diff/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/graphql-diff`
(`%USERPROFILE%\.localtools\graphql-diff` on Windows), puts `localtools-graphql-diff` on your PATH, adds a GraphQL Diff launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47112.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-graphql-diff update
localtools-graphql-diff uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/graphql-diff/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/graphql-diff/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-graphql-diff` | `brew upgrade localtools-graphql-diff` | `brew uninstall localtools-graphql-diff` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-graphql-diff` | `scoop update localtools-graphql-diff` | `scoop uninstall localtools-graphql-diff` |
| winget (Windows) | `winget install localtools.GraphqlDiff` | `winget upgrade localtools.GraphqlDiff` | `winget uninstall localtools.GraphqlDiff` |

Package-manager installs are updated by that package manager; `localtools-graphql-diff update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 100 MB of disk
- No account, no internet after install.

## Engine

@graphql-inspector/core 8 + graphql-js 16 (+ @graphql-tools/schema merge). GraphQL Inspector is the reference breaking/dangerous/safe detector; schemas are loaded and merged exactly like its CLI, so change lists are identical (tested on GitHub, GitLab, Shopify, SWAPI schemas).

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=graphql-diff.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
