# Subtitle Converter release notes

## 1.0.0 (2026-10-19)

First real release: nine text outputs, encoding inspection, shift/frame-rate/two-point sync, cleanup, lint/repair, merge/split, video track extraction, mux and burn-in. Explicit format-loss notices, bounded worker jobs and offline ffmpeg included.

## 1.0.1 (2026-10-19)

Fixes: CLI mux/burn with a relative -o write the real file; Central-European subtitles decode as windows-1250 with the detected charset and confidence shown; '->' dialogue, CR CR LF endings, skipped-cue warnings and empty-output errors; VTT karaoke and ASS Comment lines shift; ASS events sorted for other formats; sync accepts comma fractions; UI clears stale video results immediately.

## 1.0.2 (2026-10-19)

Fixes: burn --override-style on ASS files positions top/middle/bottom and sizes text in video pixels; numeric arrow dialogue kept as text; TMPlayer named as unsupported; Baltic windows-1257 detected, more UI encodings, short Western text stays windows-1252; web output limit measures the text.
