# SVG Optimizer release notes

## 1.0.0 (2026-10-16)

First release: SVGO 4.1 optimization with safe/aggressive presets and toggles (viewBox, dimensions, prefix IDs, precision, multipass), batch with zip download, side-by-side previews, XSS-safe sanitize mode, PNG export via resvg. CLI optimize command and JSON API.

## 1.0.1 (2026-10-16)

Windows: update and uninstall now start the installer through WMI so it keeps running after the tool exits; logs are UTF-8.

## 1.0.2 (2026-10-17)

Safe keeps <symbol> sprites, defs and ids; sanitize decodes CSS escapes before checking and blocks image-set/cross-fade/@font-face; each file runs in a worker with a 30 s limit and size/nesting limits; CLI -o keeps sub-folders; unique id prefixes; 32 MB paste; clear error for oversized PNG; growth shows +%.

## 1.0.3 (2026-10-17)

Security: a <style> sheet that fails the check is dropped whole and the final output is sanitized again; only xlink:/xml: prefixes; SMIL may not animate href/style/on*/base. Safe keeps empty elements with ids. Results table fits phone screens.
