# Subtitle Converter

Convert, inspect and re-time subtitles; extract, add or burn captions into video.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/subtitle-converter

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/subtitle-converter/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/subtitle-converter/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/subtitle-converter`
(`%USERPROFILE%\.localtools\subtitle-converter` on Windows), puts `localtools-subtitle-converter` on your PATH, adds a Subtitle Converter launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47125.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-subtitle-converter update
localtools-subtitle-converter uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/subtitle-converter/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/subtitle-converter/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-subtitle-converter` | `brew upgrade localtools-subtitle-converter` | `brew uninstall localtools-subtitle-converter` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-subtitle-converter` | `scoop update localtools-subtitle-converter` | `scoop uninstall localtools-subtitle-converter` |
| winget (Windows) | `winget install localtools.SubtitleConverter` | `winget upgrade localtools.SubtitleConverter` | `winget uninstall localtools.SubtitleConverter` |

Package-manager installs are updated by that package manager; `localtools-subtitle-converter update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 220 MB of disk
- No account, no internet after install.

## Engine

Native Go subtitle readers + ffmpeg/ffprobe 9.0.2. Go preserves millisecond timings and raw ASS/WebVTT payloads for timing edits; pinned ffmpeg handles container tracks and libass burn-in as a separate process.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=subtitle-converter.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
