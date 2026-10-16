# Workbook spec format

Send a JSON object with a `"sheets"` array (auto-detected, or force it with `--mode spec` / `mode=spec`).
Unknown keys are rejected, so typos fail loudly instead of being ignored. Errors give the line and column.

**Auto-detection rule:** in auto mode, a top-level object with a non-empty `"sheets"` list of objects is always read
as a spec, so `{"sheets":[{"rowz":...}]}` fails with `unknown field "rowz"` instead of silently becoming data.
To convert such an object as plain data, use `--mode data` / `mode=data`. Full example: `samples/report-spec.json`.

```json
{
  "styles": { "money": {"format": "#,##0.00"}, "title": {"bold": true, "size": 16} },
  "sheets": [ { "name": "Sales", "columns": [...], "rows": [...] } ]
}
```

## Sheet

| key | meaning |
|---|---|
| `name` | sheet name (31 characters counted like Excel, in UTF-16 units, so an emoji counts 2; no `: \ / ? * [ ]`, no leading/trailing `'`) |
| `start` | top-left cell of the header + rows block, default `A1` (leave room for a title) |
| `columns` | column definitions, see below |
| `rows` | rows as objects keyed by column `key`, or arrays by position. Without `columns`, array rows are written as-is with no header |
| `header` | write the header row (default `true` when there are columns) |
| `header_style` | style for the header (default bold, grey fill, thin border) |
| `freeze` | freeze panes below the header (default `true`) |
| `autofilter` | add filter buttons to the header |
| `table` | make the block an Excel table: `{"name": "Sales", "style": "TableStyleMedium2", "no_stripes": false, "first_column": false, "last_column": false}`. The name uses letters, digits, `_` and `.`, starts with a letter or `_`, and must not look like a cell reference (`A1`, `R1C1`). Table names are unique across the workbook (ignoring case); unnamed tables get `Table1`, `Table2`, ... avoiding your names. A table needs `columns` and a header row (`"header": false` with `table` is an error). Every header must be non-empty and unique (case-insensitive). Merges may not overlap the table |
| `cells` | single cells: `{"ref": "A1", "value": ..., "formula": "=SUM(D4:D7)", "type": ..., "format": ..., "style": ...}` |
| `merge` | ranges to merge, e.g. `["A1:F1"]` |
| `row_heights` | `{"1": 28}` |
| `conditional` | conditional formats, see below |
| `charts` | charts, see below |
| `images` | `{"cell": "H20", "data": "<base64 or data: URL>", "scale": 0.5, "alt": "logo"}` (PNG, JPEG, GIF) |

## Column

| key | meaning |
|---|---|
| `key` | field name in object rows |
| `header` | header text (default: `key`) |
| `type` | `auto` (default: numbers, booleans, ISO dates detected), `string`, `number`, `integer`, `percent`, `currency`, `date`, `datetime`, `boolean`, `formula` |
| `format` | Excel number format, e.g. `"#,##0.00"`, `"0.0%"`, `"dd mmm yyyy"`. Defaults per type: integer `#,##0`, number/currency `#,##0.00`, percent `0.00%`, date `yyyy-mm-dd`, datetime `yyyy-mm-dd hh:mm:ss` |
| `width` | column width in characters |
| `style` | style name from `styles`, or an inline style object |
| `formula` | for `type: "formula"`: a template where `{row}` is the current row, e.g. `"=B{row}*C{row}"` |

A row value may also be `{"formula": "=..."}` to put a formula in one cell.

## Style

`bold`, `italic`, `underline`, `strike`, `size`, `font`, `color`, `fill`, `align`
(`left|center|right`), `valign` (`top|center|bottom`), `wrap`, `indent`, `rotate`, `border`
(`thin|medium|thick|dashed|dotted|double`, all four sides), `border_color`, `format`.

**Colors** (`color`, `fill`, `border_color` and the conditional-format colors) are `#RRGGBB` or one of the names
`black`, `white`, `red`, `green`, `blue`, `yellow`, `orange`, `purple`, `gray` (`grey`). Anything else is rejected.

## Conditional formatting

`{"range": "C2:C100", "type": ..., ...}` with `type` one of:

- `cell` + `criteria` (`>`, `<`, `>=`, `<=`, `==`, `!=`, `between` with `min_value`/`max_value`) + `value` + optional `style` (default red text on pink)
- `formula` + `criteria` (e.g. `"=$B2>100"`)
- `top` / `bottom` + `value` (count, or percent with `"percent": true`), `average` (`"above": true`), `duplicate`, `unique`, `blanks`, `no_blanks`, `errors`, `no_errors`
- `2_color_scale` / `3_color_scale` (optional `min_color`, `mid_color`, `max_color`, `*_type`, `*_value`)
- `data_bar` (optional `bar_color`), `icon_set` (optional `icon_style`, e.g. `3Arrows`, `3TrafficLights1`)

## Charts

```json
{"cell": "H2", "type": "col", "title": "Revenue", "x_title": "Region", "y_title": "EUR",
 "width": 480, "height": 290, "legend": "bottom",
 "series": [{"name": "=D3", "categories": "A4:A7", "values": "D4:D7"}]}
```

`type`: `col`, `col_stacked`, `col_percent`, `bar`, `bar_stacked`, `bar_percent`, `line`, `area`, `area_stacked`,
`pie`, `doughnut`, `scatter`, `radar`. Ranges without a sheet name refer to the current sheet; use
`'Other sheet'!$A$2:$A$9` for other sheets. Series `name` is literal legend text (`"Revenue"`, `"FY2024"`) unless it
starts with `=`, which makes it a cell reference (`"=D3"`, `"='Other sheet'!$B$1"`). `legend`: `bottom`, `top`,
`left`, `right`, `none`.

Formulas must have balanced parentheses and quotes (`"text"` strings, `'sheet name'` references); unbalanced ones are
rejected with an error naming the formula. Formulas are stored with "recalculate on open", so Excel and LibreOffice show computed values when the file opens.

Text longer than 32,767 characters (Excel's cell limit) is truncated and reported as a warning.
