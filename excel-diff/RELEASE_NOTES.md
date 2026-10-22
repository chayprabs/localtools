# Excel Diff release notes

## 1.0.0 (2026-10-18)

- First release: .xlsx/.xlsm/.csv diff with row/column alignment, key columns, sheet rename detection, defined names, merges, validations and comments.
- Side-by-side grid with change navigation; JSON, CSV and annotated .xlsx exports; CLI exit codes like diff.

## 1.0.1 (2026-10-18)

- Shared formulas with whole-column, whole-row, lowercase and structured table references expand correctly.
- Office 2010+ (x14) data validations are compared, including input-prompt settings.
- Annotated workbook keeps added (green) and changed (yellow) fills apart.
- Workbook date-system (1900/1904) changes are reported; capped exports end with a truncated line.

## 1.0.2 (2026-10-18)

- Rows align when one column changed in every row plus inserted rows (correct, under a second); large blocks are paired by position.
- Annotated workbook works without a stylesheet and with openpyxl/pandas colours; a failed -o leaves no partial file.
- Less re-save noise (default validation attributes, empty inline strings, built-in formats, quoted sheet names in names).
- Date-system changes have their own label; one file argument exits 2.

## 1.0.3 (2026-10-21)

- A far-right cell (column XFD) no longer makes alignment slow: 500,001 cells diff in about 4 s.
- Annotated export works for styles-less workbooks with prefixed package XML.
- Defined names compare quotes inside string constants exactly.
- Overload and early-error replies reach Connection: close clients; worker temp files stay in the job folder and stale folders are swept at startup.

## 1.0.4 (2026-10-22)

- Many scattered row inserts or deletions align exactly even when a column changed in every row.
- Positional fallbacks are flagged: "approximate": true with a reason in JSON, a CLI warning and a UI banner suggesting key columns.

## 1.0.5 (2026-10-22)

Minor sweep: when several columns are equally filled, row alignment checks the most distinct columns first, so Y/N flag columns placed before an ID column no longer mis-pair an inserted row. README documents that a deleted row directly next to an inserted row is shown as one modified row (use --key when row identity matters). Runtime refreshed.
