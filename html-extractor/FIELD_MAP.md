# HTML Extractor field map

The field map is an ordered JSON array (at most 20 entries, 32 KiB):

```json
[
  {"name":"title","selector":"h2"},
  {"name":"url","selector":"a","attribute":"href"},
  {"name":"id","selector":"","attribute":"data-id"}
]
```

- The **row selector** (`--rows` / `rows`) yields one result per matching element, in document order.
- `name`: output key / CSV column (unique, at most 100 bytes). CSV columns follow map order.
- `selector`: CSS selector matched against the row's descendants; the **first** match is used. Empty = the row itself.
- `attribute` (optional): return this attribute verbatim (relative URLs stay relative). Without it, descendant text is joined with whitespace collapsed.
- Missing matches, attributes or empty values become `""`. All values are strings, so large IDs are never rounded.
- Malformed JSON reports line and column; unsupported CSS selectors are errors.
