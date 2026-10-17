# Grok Debugger

Test grok patterns against log lines with the full Logstash pattern library and highlighted matches.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/grok-debugger

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/grok-debugger/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/grok-debugger/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/grok-debugger`
(`%USERPROFILE%\.localtools\grok-debugger` on Windows), puts `localtools-grok-debugger` on your PATH, adds a Grok Debugger launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47118.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-grok-debugger update
localtools-grok-debugger uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/grok-debugger/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/grok-debugger/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-grok-debugger` | `brew upgrade localtools-grok-debugger` | `brew uninstall localtools-grok-debugger` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-grok-debugger` | `scoop update localtools-grok-debugger` | `scoop uninstall localtools-grok-debugger` |
| winget (Windows) | `winget install localtools.GrokDebugger` | `winget upgrade localtools.GrokDebugger` | `winget uninstall localtools.GrokDebugger` |

Package-manager installs are updated by that package manager; `localtools-grok-debugger update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 20 MB of disk
- No account, no internet after install.

## Engine

Own grok compiler on Go RE2 + official Logstash pattern sets (ECS v1 and legacy). Embeds the unmodified logstash-patterns-core files, so field names match Logstash 8; RE2 is linear-time, so no pattern can hang. Existing Go grok libraries ship their own rewritten legacy-only pattern copies.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=grok-debugger.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
