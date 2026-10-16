# YAML JSON Query release notes

## 1.0.0 (2026-10-16)

First release of localtools-yaml-json-query: query, convert and patch YAML, JSON, TOML, XML, INI, CSV/TSV and .properties with yq (jq-style) expressions or JMESPath, plus RFC 6902 JSON Patch and RFC 7386 merge patch applied on the YAML node tree so comments, anchors and key order are kept. Multi-document YAML, parse errors with line and column. One-page UI, `eval` / `convert` / `patch` CLI with in-place edit, JSON API. Windows x64, macOS arm64/x64, Linux x64/arm64.

## 1.0.1 (2026-10-17)

Security and correctness fixes: YAML documents whose aliases expand past 5 million nodes ("billion laughs") are rejected with "alias expansion too large" instead of hanging; every UI/API query and patch now runs in a worker process with a 30 s / 2 GB limit, so an expensive expression can no longer block the tool. JSON numbers keep their exact text (big integers, 1.10) through queries, patches and conversions; TOML local dates and times are read as strings instead of failing. UI: a chosen file can be removed (typing replaces it), and an error clears the previous result and disables Download.
