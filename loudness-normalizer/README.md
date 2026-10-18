# Loudness Normalizer

Normalize audio loudness to EBU R128 / LUFS targets with two-pass ffmpeg loudnorm.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/loudness-normalizer

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/loudness-normalizer/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/loudness-normalizer/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/loudness-normalizer`
(`%USERPROFILE%\.localtools\loudness-normalizer` on Windows), puts `localtools-loudness-normalizer` on your PATH, adds a Loudness Normalizer launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47124.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-loudness-normalizer update
localtools-loudness-normalizer uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/loudness-normalizer/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/loudness-normalizer/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-loudness-normalizer` | `brew upgrade localtools-loudness-normalizer` | `brew uninstall localtools-loudness-normalizer` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-loudness-normalizer` | `scoop update localtools-loudness-normalizer` | `scoop uninstall localtools-loudness-normalizer` |
| winget (Windows) | `winget install localtools.LoudnessNormalizer` | `winget upgrade localtools.LoudnessNormalizer` | `winget uninstall localtools.LoudnessNormalizer` |

Package-manager installs are updated by that package manager; `localtools-loudness-normalizer update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 210 MB of disk
- No account, no internet after install.

## Engine

ffmpeg + ffprobe 9.0.2, EBU R128 ebur128 + two-pass loudnorm (bundled). ffmpeg supplies real EBU R128 measurement and two-pass loudnorm with a true-peak limiter; SHA256-pinned sidecars run offline as killable children on every supported OS.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=loudness-normalizer.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
