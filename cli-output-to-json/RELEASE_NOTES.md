# CLI Output to JSON release notes

## 1.0.0 (2026-10-18)

First release. Paste or upload command output and parse it offline with jc 1.26.0 (243 parsers) or TextFSM 2.1.0 / ntc-templates 9.3.0 (969 indexed templates) to JSON, JSON Lines, or CSV. Suggestions never auto-select a parser.

## 1.0.1 (2026-10-18)

macOS parses again. Setting the 768 MiB address-space cap raised on macOS and the worker exited before writing a result, so POST /api/parse returned 422. That call is ignored when the OS refuses it. Linux still applies the cap.
