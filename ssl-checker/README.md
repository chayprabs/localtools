# SSL Checker

Check a domain's TLS certificate chain, expiry, supported protocols, DNSSEC and CAA records.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/ssl-checker

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/ssl-checker/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/ssl-checker/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/ssl-checker`
(`%USERPROFILE%\.localtools\ssl-checker` on Windows), puts `localtools-ssl-checker` on your PATH, adds a SSL Checker launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47121.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-ssl-checker update
localtools-ssl-checker uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/ssl-checker/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/ssl-checker/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-ssl-checker` | `brew upgrade localtools-ssl-checker` | `brew uninstall localtools-ssl-checker` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-ssl-checker` | `scoop update localtools-ssl-checker` | `scoop uninstall localtools-ssl-checker` |
| winget (Windows) | `winget install localtools.SslChecker` | `winget upgrade localtools.SslChecker` | `winget uninstall localtools.SslChecker` |

Package-manager installs are updated by that package manager; `localtools-ssl-checker update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 20 MB of disk
- No account, no internet after install.

## Engine

Go crypto/tls + crypto/x509 + miekg/dns, Mozilla roots from golang.org/x/crypto/x509roots. Go's TLS stack and verifier give real handshakes and chain checks without OpenSSL; miekg/dns sets DO/AD/CD bits for DNSSEC; the Go team's CCADB-generated Mozilla bundle keeps distrust-after constraints.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=ssl-checker.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
