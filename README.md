# localtools

Free, offline tools that run on your machine. Each one is a small local app: install it with one command,
it opens in your browser at `http://127.0.0.1:<port>`, and your files never leave your computer.
No account, no upload, no telemetry.

Browse all tools, with docs and how-tos: **https://tools.chaitanyaprabuddha.com**

## Tools

<!-- tools -->
_First releases are on their way._
<!-- /tools -->

## Install

Every tool has a folder here with its installers. One line, no admin rights:

```powershell
# Windows (PowerShell)
irm https://raw.githubusercontent.com/chayprabs/localtools/main/<tool>/install.ps1 | iex
```

```sh
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/<tool>/install.sh | bash
```

The installer downloads the tool's release zip from this repo's
[Releases](https://github.com/chayprabs/localtools/releases), checks its SHA-256, unpacks it to `~/.localtools/<tool>`,
puts `localtools-<tool>` on your PATH (`~/.localtools/bin`), adds a launcher (Start Menu, `~/Applications`, or your
app menu) and opens the tool. Re-running it updates. `localtools-<tool> update` and `localtools-<tool> uninstall` do
the same from the command line. Set `LOCALTOOLS_NO_OPEN=1` to install without opening the browser.

Package managers, where a tool supports them:
[Homebrew](https://github.com/chayprabs/homebrew-localtools) (`brew install chayprabs/localtools/localtools-<tool>`),
[Scoop](https://github.com/chayprabs/scoop-localtools), winget (`localtools.<Tool>`), npm and PyPI (`localtools-<tool>`),
and Docker images on `ghcr.io/chayprabs/localtools-<tool>`. Each tool's README lists which apply.

Every install is tested from scratch on Windows (PowerShell 5.1), macOS and Ubuntu by the
[clean-install workflow](.github/workflows/clean-install.yml).

## Report an issue

[Open an issue](https://github.com/chayprabs/localtools/issues/new/choose) and pick the tool. Each tool's page also has a
"Report an issue" link.

## License

MIT. Bundled third-party engines keep their own licenses, listed in each install's `THIRD_PARTY_NOTICES.md`.
