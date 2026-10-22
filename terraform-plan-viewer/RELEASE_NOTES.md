# Terraform Plan Viewer release notes

## 1.0.0 (2026-10-18)

First release: summary counts matching the CLI plan line, destructive changes first with replacement reasons, attribute diffs with sensitive values masked, blast radius from configuration references, drift, outputs, checks, risk flags, Markdown/JSON export, CLI summary and check --fail-on.

## 1.0.1 (2026-10-18)

Fail-closed redaction of sensitive values (type changes, unknown aggregates, deep nesting, unpropagated marks); changes beyond 2,000 bytes are detected and shown around the difference; depends_on on a whole module counts in the blast radius; incomplete blast radii are marked partial; built-in-only OpenTofu plans are not mislabelled; no-op imports are listed; drift pages past 200.

## 1.0.2 (2026-10-18)

The sensitive-equality guard no longer hides ordinary values: only marked strings of 8+ bytes (any length within the same resource), never bools, numbers or short strings; hidden values are labelled (matches a sensitive value). Import IDs and check messages pass through the guard. Untraced blast radii past the graph limit say unknown.

## 1.0.3 (2026-10-22)

The sensitive-equality guard no longer hides ordinary values: only marked strings of 8+ bytes (any length within the same resource), never bools, numbers or short strings; hidden values are labelled (matches a sensitive value). Import IDs and check messages pass through the guard. Untraced blast radii past the graph limit say unknown.
