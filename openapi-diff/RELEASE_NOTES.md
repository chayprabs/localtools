# OpenAPI Diff release notes

## 1.0.0 (2026-10-16)

First release: OpenAPI 3.0/3.1 and Swagger 2.0 diff with oasdiff's breaking-change checks, per-operation report, PR-ready Markdown, JSON and a CI check command.

## 1.0.1 (2026-10-17)

Late openapi/swagger keys (Stripe, Kubernetes JSON) detected; single upload is the root, root picker for zips with several specs; Markdown code spans keep | < > and backticks; worker process stops when the client disconnects; UI lists the first 400 changes; cleaner error messages.

## 1.0.2 (2026-10-17)

Large diffs stay responsive: capped summary in the page, full Markdown/JSON downloaded from the local server; at most 2 comparisons at once (503 when busy); the worker exits with the server.
