# GitHub Actions Linter release notes

## 1.0.0 (2026-10-18)

First real offline release: actionlint 1.7.12 and zizmor 1.31.1; paste/upload batches, CLI, JSON API and downloadable findings with suggested fixes. Explicit offline scope and bounded workers. Linux requires glibc 2.34+.

## 1.0.1 (2026-10-18)

Fix: bundled zizmor engine found when launched through the macOS/Linux symlink shim (security checks returned 422 on macOS).

## 1.0.2 (2026-10-18)

Per-file zizmor audits (failures skip only that file, with the reason), composite action.yml support, folder/zip discovery, SARIF and Markdown, --fail-on, ignores, cross-engine dedupe, fix snippets per rule.

## 1.0.3 (2026-10-18)

No temp-file leaks on cancelled jobs, discovery before limits (1,000 files / 16 MiB), one-run zizmor batches, real-world action.yml inputs accepted, engine failure fails --fail-on, review minors.
