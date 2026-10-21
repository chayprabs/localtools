# SSL Checker release notes

## 1.0.0 (2026-10-17)

First release: chain trust against system and Mozilla roots with exact failure reasons, TLS 1.0-1.3 and weak-cipher probes, stapled OCSP, DNS/DNSSEC/CAA, offline PEM/DER/PKCS#7 inspection, JSON export and a CI-friendly CLI.

## 1.0.1 (2026-10-18)

Weak ciphers are probed with raw ClientHellos per class (NULL/export, RC4, 3DES, RSA key exchange, CBC), matching what servers really accept; CBC and RSA key exchange are informational. DNS lookup failures and NXDOMAIN are reported as such, errors are one human line, oversized/JSON API bodies get 413/415, inspect accepts flags after the file, UI spacing fixed.

## 1.0.2 (2026-10-22)

Weak-cipher probes stop as soon as the client disconnects, retry a dropped connection once, and still report accepted suites (e.g. RC4-only servers) when the main handshake fails. Oversized form or certificate input returns 413. Long cipher names wrap on narrow screens; code text renders without ligatures.
