# Loudness Normalizer release notes

## 1.0.0 (2026-10-19)

First release: EBU R128 LUFS/LRA/true-peak measurement, loudness graphs, two-pass normalization, platform/custom targets, peak and gain modes, before/after reports, individual and batch downloads. Bundles ffmpeg 9.0.2 with source tarballs attached.

## 1.0.1 (2026-10-19)

Fix quiet-audio true/sample-peak precision and cap peak-mode gain at +60 dB. Remeasure up to three encodes, use a final oversampled limiter for transient overshoot, and retain the best attempt. Web deadlines scale with duration; CLI has no time limit. Keep narrow-screen file values/actions visible. Document the conservative EBU case 16 engine limit and only shipped architectures.
