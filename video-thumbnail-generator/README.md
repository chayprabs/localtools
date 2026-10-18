# Video Thumbnail Generator

Generate thumbnails, frame grids and contact sheets from video files with ffmpeg.

Part of [localtools](https://tools.chaitanyaprabuddha.com): free tools that run entirely on your machine. Your files never leave it.
Details and how-to: https://tools.chaitanyaprabuddha.com/video-thumbnail-generator

## Install

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/chayprabs/localtools/main/video-thumbnail-generator/install.ps1 | iex
```

**macOS / Linux**:

```sh
curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/video-thumbnail-generator/install.sh | bash
```

The installer downloads the release for your OS, verifies its SHA-256, installs to `~/.localtools/video-thumbnail-generator`
(`%USERPROFILE%\.localtools\video-thumbnail-generator` on Windows), puts `localtools-video-thumbnail-generator` on your PATH, adds a Video Thumbnail Generator launcher
(Start Menu / Applications / app menu), and opens it in your browser at http://127.0.0.1:47123.
Set `LOCALTOOLS_NO_OPEN=1` to install without opening it.

## Update / uninstall

```sh
localtools-video-thumbnail-generator update
localtools-video-thumbnail-generator uninstall
```

Or re-run the install command (it updates in place), or run the uninstall script:
`irm https://raw.githubusercontent.com/chayprabs/localtools/main/video-thumbnail-generator/uninstall.ps1 | iex` (Windows), `curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/video-thumbnail-generator/uninstall.sh | bash` (macOS/Linux).

## Package managers

| | install | update | uninstall |
|---|---|---|---|
| Homebrew (macOS, Linux) | `brew install chayprabs/localtools/localtools-video-thumbnail-generator` | `brew upgrade localtools-video-thumbnail-generator` | `brew uninstall localtools-video-thumbnail-generator` |
| Scoop (Windows) | `scoop bucket add localtools https://github.com/chayprabs/scoop-localtools; scoop install localtools-video-thumbnail-generator` | `scoop update localtools-video-thumbnail-generator` | `scoop uninstall localtools-video-thumbnail-generator` |
| winget (Windows) | `winget install localtools.VideoThumbnailGenerator` | `winget upgrade localtools.VideoThumbnailGenerator` | `winget uninstall localtools.VideoThumbnailGenerator` |

Package-manager installs are updated by that package manager; `localtools-video-thumbnail-generator update` is for script installs.

## Requirements

- Windows 10/11, macOS 12+, Linux (glibc), x64 and Apple Silicon
- About 200 MB of disk
- No account, no internet after install.

## Engine

ffmpeg + ffprobe 9.0.2 (bundled: BtbN gpl-shared on Windows/Linux, Martin Riedl static builds on macOS). ffmpeg decodes practically every codec and container, seeks frame-accurately and tone-maps HDR with zscale; it runs as a killable child process, so the tool works offline on every OS with no system install.

## Report an issue

[Open a bug report](https://github.com/chayprabs/localtools/issues/new?template=video-thumbnail-generator.yml). Release notes: [RELEASE_NOTES.md](RELEASE_NOTES.md).

MIT licensed. Bundled third-party engines keep their own licenses (see `THIRD_PARTY_NOTICES.md` in the install folder).
