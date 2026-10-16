# YAML JSON Query

Query and edit YAML, JSON, XML, TOML and INI with yq expressions and apply RFC 6902 JSON Patch, keeping comments.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/yaml-json-query

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/yaml-json-query/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/yaml-json-query/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/yaml-json-query`
(`%USERPROFILE%\.localtools\yaml-json-query` on Windows), puts `localtools-yaml-json-query` on your PATH, adds a YAML JSON Query launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47110.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-yaml-json-query update
localtools-yaml-json-query uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/yaml-json-query/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/yaml-json-query/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-yaml-json-query` | `brew upgrade localtools-yaml-json-query` | `brew uninstall localtools-yaml-json-query` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-yaml-json-query` | `scoop update localtools-yaml-json-query` | `scoop uninstall localtools-yaml-json-query` |
| winget (Windows) | `winget install localtools.YamlJsonQuery` | `winget upgrade localtools.YamlJsonQuery` | `winget uninstall localtools.YamlJsonQuery` |

Package-manager installs are updated by that package manager; `localtools-yaml-json-query update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 30 MB of disk
- No account, no internet after install.

## Engine

Go + yq (mikefarah) + RFC 6902 JSON Patch. yq is the de-facto YAML query tool, preserves comments, and handles JSON/XML/TOML/INI as a Go library.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=yaml-json-query.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
