# Terraform Plan Viewer

Review terraform or OpenTofu plan JSON offline: destructive changes first, attribute diffs, blast radius, drift and risk flags.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/terraform-plan-viewer

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/terraform-plan-viewer/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/terraform-plan-viewer/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/terraform-plan-viewer`
(`%USERPROFILE%\.localtools\terraform-plan-viewer` on Windows), puts `localtools-terraform-plan-viewer` on your PATH, adds a Terraform Plan Viewer launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47115.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-terraform-plan-viewer update
localtools-terraform-plan-viewer uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/terraform-plan-viewer/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/terraform-plan-viewer/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-terraform-plan-viewer` | `brew upgrade localtools-terraform-plan-viewer` | `brew uninstall localtools-terraform-plan-viewer` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-terraform-plan-viewer` | `scoop update localtools-terraform-plan-viewer` | `scoop uninstall localtools-terraform-plan-viewer` |
| winget (Windows) | `winget install localtools.TerraformPlanViewer` | `winget upgrade localtools.TerraformPlanViewer` | `winget uninstall localtools.TerraformPlanViewer` |

Package-manager installs are updated by that package manager; `localtools-terraform-plan-viewer update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 25 MB of disk
- No account, no internet after install.

## Engine

Go + hashicorp/terraform-json. terraform-json is HashiCorp's typed Go model of terraform show -json output; decoded with json.Number so values stay exact. OpenTofu emits the same format.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=terraform-plan-viewer.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
