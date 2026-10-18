# Kubernetes Manifest Checker

Score Kubernetes YAML and Helm-rendered manifests for production readiness and security, with a fix snippet per finding.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/k8s-manifest-checker

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/k8s-manifest-checker/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/k8s-manifest-checker/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/k8s-manifest-checker`
(`%USERPROFILE%\.localtools\k8s-manifest-checker` on Windows), puts `localtools-k8s-manifest-checker` on your PATH, adds a Kubernetes Manifest Checker launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47114.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-k8s-manifest-checker update
localtools-k8s-manifest-checker uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/k8s-manifest-checker/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/k8s-manifest-checker/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-k8s-manifest-checker` | `brew upgrade localtools-k8s-manifest-checker` | `brew uninstall localtools-k8s-manifest-checker` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-k8s-manifest-checker` | `scoop update localtools-k8s-manifest-checker` | `scoop uninstall localtools-k8s-manifest-checker` |
| winget (Windows) | `winget install localtools.K8sManifestChecker` | `winget upgrade localtools.K8sManifestChecker` | `winget uninstall localtools.K8sManifestChecker` |

Package-manager installs are updated by that package manager; `localtools-k8s-manifest-checker update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 40 MB of disk
- No account, no internet after install.

## Engine

Go + kube-score library + PSS-aligned checks. kube-score (Go, MIT) checks single objects and cross-object relationships with mature messages; localtools adds line-exact Pod Security Standards checks, API removals per Kubernetes version and duplicate detection.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=k8s-manifest-checker.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
