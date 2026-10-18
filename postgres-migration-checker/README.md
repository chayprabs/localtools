# Postgres Migration Checker

Check PostgreSQL migrations for the lock each statement takes, what it blocks, and a safe rewrite.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/postgres-migration-checker

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/postgres-migration-checker/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/postgres-migration-checker/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/postgres-migration-checker`
(`%USERPROFILE%\.localtools\postgres-migration-checker` on Windows), puts `localtools-postgres-migration-checker` on your PATH, adds a Postgres Migration Checker launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47116.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-postgres-migration-checker update
localtools-postgres-migration-checker uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/postgres-migration-checker/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/postgres-migration-checker/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| PyPI | `pipx install localtools-postgres-migration-checker` (or `uv tool install localtools-postgres-migration-checker`) | `pipx upgrade localtools-postgres-migration-checker` | `pipx uninstall localtools-postgres-migration-checker` |

Package-manager installs are updated by that package manager; `localtools-postgres-migration-checker update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 120 MB of disk
- No account, no internet after install.

## Engine

BSD-2 postgast 0.2.0 / libpg_query PostgreSQL 18.4. postgast calls the real libpg_query parser, so lock and rewrite rules follow a typed PostgreSQL AST instead of regex splits. The abandoned GPL pglast scaffold is not bundled. PyPI has postgast wheels for Windows x64, Linux x64 and macOS ARM64. A plain Intel macOS PyPI install is unavailable: upstream has no Intel wheel, and its published source archive lacks build headers. Use the self-contained Intel Mac ZIP, or the bundled MacIntel postgast wheel with Python 3.13: `pipx install localtools-postgres-migration-checker --python python3.13 --pip-args="--find-links https://github.com/chayprabs/localtools/releases/download/postgres-migration-checker-v1.0.0/postgast-0.2.0-cp313-cp313-macosx_10_13_x86_64.whl"`. That wheel is built unmodified from the upstream v0.2.0 Git tag.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=postgres-migration-checker.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
