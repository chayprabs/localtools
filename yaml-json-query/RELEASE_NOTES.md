# YAML JSON Query release notes

## 1.0.0 (2026-10-16)

First release of localtools-yaml-json-query: query, convert and patch YAML, JSON, TOML, XML, INI, CSV/TSV and .properties with yq (jq-style) expressions or JMESPath, plus RFC 6902 JSON Patch and RFC 7386 merge patch applied on the YAML node tree so comments, anchors and key order are kept. Multi-document YAML, parse errors with line and column. One-page UI, `eval` / `convert` / `patch` CLI with in-place edit, JSON API. Windows x64, macOS arm64/x64, Linux x64/arm64.

## 1.0.1 (2026-10-17)

Security and correctness fixes: YAML documents whose aliases expand past 5 million nodes ("billion laughs") are rejected with "alias expansion too large" instead of hanging; every UI/API query and patch now runs in a worker process with a 30 s / 2 GB limit, so an expensive expression can no longer block the tool. JSON numbers keep their exact text (big integers, 1.10) through queries, patches and conversions; TOML local dates and times are read as strings instead of failing. UI: a chosen file can be removed (typing replaces it), and an error clears the previous result and disables Download.

## 1.0.2 (2026-10-17)

Large-input and robustness fixes: the UI/API upload limit is now 16 MB, which reliably fits the 2 GB worker (measured peak heap: 1.0 GB for 16 MB of dense JSON, 1.1 GB for 16 MB of Kubernetes YAML); bigger inputs get a clear "input too large" message. Workers stop when the request is cancelled, when the tool exits, or at their own deadline, and at most two run at once. JSON: nesting deeper than 10000 levels is a clean error, duplicate keys keep the last value, a UTF-8 BOM is accepted. YAML numbers like 0b101, 017, .inf and integers beyond 64 bits convert to JSON/TOML correctly or fail with a clear message. UI: Ctrl+Enter no longer starts a second run while one is in progress.

## 1.0.3 (2026-10-21)

Multi-document YAML expressions run per document (linear time). YAML output memory is bounded, so 16 MB of typical JSON converts to YAML in the UI. TOML +nan/-nan input works; inf/NaN are written as .inf/.nan in YAML; floats beyond 64 bits are a clear error for TOML. Oversized uploads get HTTP 413, busy workers HTTP 503. --in-place writes atomically.
