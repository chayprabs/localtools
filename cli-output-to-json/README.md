# CLI Output to JSON

Convert command output (ls, ps, netstat, dig, network device show commands) into JSON with jc and TextFSM.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/cli-output-to-json

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/cli-output-to-json/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/cli-output-to-json/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/cli-output-to-json`
(`%USERPROFILE%\.localtools\cli-output-to-json` on Windows), puts `localtools-cli-output-to-json` on your PATH, adds a CLI Output to JSON launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47119.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-cli-output-to-json update
localtools-cli-output-to-json uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/cli-output-to-json/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/cli-output-to-json/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| PyPI | `pipx install localtools-cli-output-to-json` (or `uv tool install localtools-cli-output-to-json`) | `pipx upgrade localtools-cli-output-to-json` | `pipx uninstall localtools-cli-output-to-json` |

Package-manager installs are updated by that package manager; `localtools-cli-output-to-json update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 100 MB of disk
- No account, no internet after install.

## Engine

jc + TextFSM/ntc-templates. jc 1.26.0 parses 243 OS commands; TextFSM 2.1.0 with ntc-templates 9.3.0 adds 969 indexed network-device templates. Both are pinned in the portable CPython zip and run offline, with no command execution.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=cli-output-to-json.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
