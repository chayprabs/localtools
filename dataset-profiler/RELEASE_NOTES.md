# Dataset Profiler release notes

## 1.0.0 (2026-10-18)

First release: profiles (types, exact nulls/distinct, stats, quartiles, top values, histograms, patterns, formats, sample rows), drift between two files, JSON/Markdown/HTML/CSV export.

## 1.0.1 (2026-10-18)

Fixes: NaN/Inf/near-1e308 floats no longer abort a profile (finite stats plus non-finite counts); CSV integers beyond int64 stay exact; validated ipv4/ISO-date counts; UTC timestamps; semicolon/pipe CSV delimiter detection; numeric drift across type changes; clearer errors; stale temp cleanup.
