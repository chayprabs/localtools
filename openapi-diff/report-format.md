# OpenAPI Diff: JSON report format

Returned by `POST /api/diff` and by `localtools-openapi-diff check BASE REVISION --format json`.

```json
{
  "base":     { "title": "Petstore", "version": "1.0.0", "openapi": "3.0.3" },
  "revision": { "title": "Petstore", "version": "2.0.0", "openapi": "3.0.3" },
  "counts":   { "breaking": 6, "warning": 0, "info": 3 },
  "groups": [
    {
      "operation": "GET /pets",
      "changes": [
        {
          "id": "new-required-request-parameter",
          "severity": "breaking",
          "operation": "GET /pets",
          "text": "added the new required `query` request parameter `owner`",
          "comment": "",
          "client_action": "Clients must always send this value; requests without it will be rejected.",
          "source": "petstore-v2.yaml:19"
        }
      ]
    }
  ],
  "markdown": "## API changes: ..."
}
```

| field | meaning |
|---|---|
| `counts` | number of changes per severity |
| `groups[]` | one entry per operation (`METHOD /path`) or spec section (e.g. `components`). Groups with the worst severity come first. |
| `id` | oasdiff check ID ([list of checks](https://github.com/oasdiff/oasdiff/blob/main/docs/BREAKING-CHANGES-EXAMPLES.md)) |
| `severity` | `breaking` (oasdiff error), `warning`, or `info` (non-breaking) |
| `comment` | oasdiff's extra explanation, when it has one |
| `client_action` | what API clients must do (breaking and warning changes only), derived from the rule's area, direction and kind |
| `source` | `file:line` in the revision, or `base file:line` when the element only exists in the base |
| `markdown` | PR-ready summary (HTTP API only, the CLI prints it with `--format markdown`) |

Fields with empty values may be omitted. CLI exit codes: `0` nothing at or above `--fail-on` (default `breaking`), `1` found, `2` error.
Upload fields for the HTTP API: `base`, `revision` (spec file(s) or one `.zip` each), `base_text`, `revision_text`, and optionally `base_entry` / `revision_entry` (root file inside a zip).
