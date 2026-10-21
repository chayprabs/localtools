# JSON to Excel release notes

## 1.0.0 (2026-10-16)

First release: JSON arrays, JSON Lines and objects of arrays to typed, formatted .xlsx (flattened nested objects, real numbers/booleans/dates, frozen filterable header); declarative spec mode with formats, styles, formulas, merges, conditional formatting, tables, charts and images; web UI, CLI and JSON API.

## 1.0.1 (2026-10-16)

Fixes from review: - Spec images (PNG, JPEG, GIF) work in the shipped binary (decoders were only registered in tests). - Very wide inputs are fast: 16,384 columns convert in about 1 s (was minutes). - Malformed JSON errors give line and column. - Keys that collide after flattening (`a.b` next to `{"a":{"b":..}}`) are kept as `a.b (2)` with a warning. - Spec validation: table names and headers, colors (#RRGGBB or named), balanced formulas, merges overlapping tables. - Chart series names are literal text unless they start with `=` (`"FY2024"` is a name, `"=D3"` a reference). Breaking: 1.0.0 specs using `"name": "D3"` as a reference need `"=D3"`. - Correct `<dimension>` on data sheets; text truncation warning in spec mode; sheet name and cell limits counted in UTF-16 units like Excel. - Auto mode: any `{"sheets":[{...}]}` is read as a spec, so typos fail loudly (use mode data for plain data). - UI clears the previous workbook after an error. Spec format: https://github.com/chayprabs/localtools/blob/main/json-to-excel/SPEC.md (also in the zip).

## 1.0.2 (2026-10-16)

- Table names must be unique across the workbook (ignoring case); duplicates are rejected, and unnamed tables get generated names that avoid yours. - A table with "header": false is an error (Excel tables need a header row) instead of being dropped silently. - Row counts for spec sheets without a header are correct. - In an object of arrays, empty arrays are skipped with a warning instead of failing the whole input.

## 1.0.3 (2026-10-21)

- Conditional formats, icon styles and number formats are validated before writing: one-line errors with sheet and rule number, never a workbook Excel has to repair. - Plain-language JSON type errors (e.g. a number where a string is needed); UTF-16/UTF-32 input is rejected with a clear message; headers longer than 32,767 characters are truncated with a warning. - Web/API conversions run in a separate process with a two-minute deadline, at most two at a time (HTTP 503 otherwise); oversized uploads get a JSON 413. - The CLI writes outputs atomically; code text shows operators without font ligatures.
