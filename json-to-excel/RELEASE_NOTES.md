# JSON to Excel release notes

## 1.0.0 (2026-10-16)

First release: JSON arrays, JSON Lines and objects of arrays to typed, formatted .xlsx (flattened nested objects, real numbers/booleans/dates, frozen filterable header); declarative spec mode with formats, styles, formulas, merges, conditional formatting, tables, charts and images; web UI, CLI and JSON API.

## 1.0.1 (2026-10-16)

Fixes from review: - Spec images (PNG, JPEG, GIF) work in the shipped binary (decoders were only registered in tests). - Very wide inputs are fast: 16,384 columns convert in about 1 s (was minutes). - Malformed JSON errors give line and column. - Keys that collide after flattening (`a.b` next to `{"a":{"b":..}}`) are kept as `a.b (2)` with a warning. - Spec validation: table names and headers, colors (#RRGGBB or named), balanced formulas, merges overlapping tables. - Chart series names are literal text unless they start with `=` (`"FY2024"` is a name, `"=D3"` a reference). Breaking: 1.0.0 specs using `"name": "D3"` as a reference need `"=D3"`. - Correct `<dimension>` on data sheets; text truncation warning in spec mode; sheet name and cell limits counted in UTF-16 units like Excel. - Auto mode: any `{"sheets":[{...}]}` is read as a spec, so typos fail loudly (use mode data for plain data). - UI clears the previous workbook after an error. Spec format: https://github.com/chayprabs/localtools/blob/main/json-to-excel/SPEC.md (also in the zip).
