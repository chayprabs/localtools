# Excel Diff release notes

## 1.0.0 (2026-10-18)

- First release: .xlsx/.xlsm/.csv diff with row/column alignment, key columns, sheet rename detection, defined names, merges, validations and comments.
- Side-by-side grid with change navigation; JSON, CSV and annotated .xlsx exports; CLI exit codes like diff.

## 1.0.1 (2026-10-18)

- Shared formulas with whole-column, whole-row, lowercase and structured table references expand correctly.
- Office 2010+ (x14) data validations are compared, including input-prompt settings.
- Annotated workbook keeps added (green) and changed (yellow) fills apart.
- Workbook date-system (1900/1904) changes are reported; capped exports end with a truncated line.
