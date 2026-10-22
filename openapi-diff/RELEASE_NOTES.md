# OpenAPI Diff release notes

## 1.0.0 (2026-10-16)

First release: OpenAPI 3.0/3.1 and Swagger 2.0 diff with oasdiff's breaking-change checks, per-operation report, PR-ready Markdown, JSON and a CI check command.

## 1.0.1 (2026-10-17)

Late openapi/swagger keys (Stripe, Kubernetes JSON) detected; single upload is the root, root picker for zips with several specs; Markdown code spans keep | < > and backticks; worker process stops when the client disconnects; UI lists the first 400 changes; cleaner error messages.

## 1.0.2 (2026-10-17)

Large diffs stay responsive: capped summary in the page, full Markdown/JSON downloaded from the local server; at most 2 comparisons at once (503 when busy); the worker exits with the server.

## 1.0.3 (2026-10-21)

Reports kept per comparison and never evicted while running or fresh (fixes 422 on parallel comparisons); stale temp folders swept at startup, reports removed on exit, 30-minute expiry enforced every minute; smaller page summary; 413 delivered to Connection: close clients; pasted specs up to 64 MB, up to 5000 files per side; oasdiff 1.34.0.

## 1.0.4 (2026-10-22)

Minor sweep: 5,000 files per side now really work (multipart header limit raised); a reports folder removed by another instance's startup sweep is recreated instead of failing with 503; $ref errors show the path relative to the upload, never the server temp path; PUT/PATCH/DELETE on /api/diff answer JSON 405; a failed comparison clears the previous result and disables downloads; long property paths wrap at phone width; message patterns are compiled once per rule; --help describes the summary + report_id API. README documents the practical size for very large specs and the Ctrl+C temp cleanup.
