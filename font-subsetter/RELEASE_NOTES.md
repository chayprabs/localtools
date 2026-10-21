# Font Subsetter release notes

## 1.0.0 (2026-10-16)

First release: subset by Unicode presets, text or ranges; keep/drop OpenType features and hinting; pin or limit variable axes; WOFF2/WOFF/TTF/OTF output with size, coverage and license report, live preview and @font-face CSS (fontTools + brotli).

## 1.0.1 (2026-10-16)

Fixes the macOS/Linux launcher when started through the ~/.localtools/bin shim, and update on macOS/Linux.

## 1.0.2 (2026-10-22)

Report the complete missing-character count while limiting examples to 500. Reject Unicode values above U+10FFFF and axis pins/ranges outside the font bounds. Give duplicate uploads distinct numbered output names with matching CSS links. Emit correct oblique angle ranges for variable slant fonts, return JSON errors for unsupported HTTP methods, and include the current shared UI fixes.
