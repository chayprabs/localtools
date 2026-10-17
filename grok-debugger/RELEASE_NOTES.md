# Grok Debugger release notes

## 1.0.0 (2026-10-17)

First release: grok pattern testing with the full Logstash ECS/legacy library, highlighted matches, pattern suggestion, Logstash/Elasticsearch/Vector/Fluent Bit export, CLI and JSON API.

## 1.0.1 (2026-10-17)

Matches run in killable worker processes (pattern/regex caps, 503 when busy, killed on timeout or disconnect); integers beyond int64/2^53 stay exact; legacy HAPROXYDATE milliseconds fixed and adapted library patterns flagged; stale export cleared; better suggestions (JSON, units, syslog PRI/RFC 5424, nginx dates, key=value).
