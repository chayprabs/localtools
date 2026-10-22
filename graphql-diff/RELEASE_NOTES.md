# GraphQL Diff release notes

## 1.0.0 (2026-10-18)

First release: breaking/dangerous/safe schema diff with reasons and migration hints, SDL + introspection JSON, multi-file merge, operation checks, JSON/Markdown, CLI --fail-on.

## 1.0.1 (2026-10-18)

Option rules run before simplifyChanges like the CLI (ignore descriptions no longer hides breaking changes); executables keep file:line:col on SDL errors; workers stop with the server or at their deadline; closing the page stops its job; unknown fragments mark only that file invalid; 150k types / 50k changes in ~15 s; per-file remove.

## 1.0.2 (2026-10-22)

Deep schemas that load but cannot be compared name both files; missing files after options report 'no such file'; larger remove buttons on phones; ligatures off in all code text; uploads drained before 403.
