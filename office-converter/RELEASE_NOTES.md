# Office Converter release notes

## 1.0.1 (2026-10-22)

1.0.1 pins both previously tested base-image digests and signed Debian snapshot 20261020T000000Z, LibreOffice 4:25.2.3-2+deb13u8 and Poppler 25.03.0-5+deb13u4; syncs bounded Host/Origin upload rejection draining. Public image ghcr.io/chayprabs/localtools-office-converter:1.0.1 (also latest), digest sha256:5f69d9aec41b53e4d82a2167f9c205ed598e3f7efebd127f8e45faa8e097b840. Source fb520f840aa6eb8fac7b51bcbb9cd2a8cf993142. Linux CI/publish https://github.com/chayprabs/office-converter/actions/runs/39732820965 passed 3 Go tests, 15 Python tests, 105 shipping-image assertions (six real formats and exact LibreOffice reference pixels), 4 headless UI runs under installed wrapper constraints. GHCR package made public 2026-10-22; anonymous manifest/config pull of 1.0.1 and latest verified at that digest.
