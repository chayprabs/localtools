# Kubernetes Manifest Checker release notes

## 1.0.0 (2026-10-18)

First release: kube-score 1.20.0 plus host namespace/hostPath/capability/privilege-escalation/seccomp checks, API removals per target Kubernetes 1.25-1.34, duplicates; per-object grades; fix snippet per finding; files, folders and zips; JSON, SARIF and Markdown; CLI --fail-on.

## 1.0.1 (2026-10-18)

Fix nested-zip memory growth and enforce 16 MiB report limits for every format; add a 2,000-container limit, baseline/restricted capability allowlists, host ports, sysctls, SELinux, procMount and AppArmor checks; decode UTF-16, normalize pod boolean spellings, improve field/archive errors and remove duplicate API findings and kit demo pages.

## 1.0.2 (2026-10-22)

Fix nested-zip memory growth and enforce 16 MiB report limits for every format; add a 2,000-container limit, baseline/restricted capability allowlists, host ports, sysctls, SELinux, procMount and AppArmor checks; decode UTF-16, normalize pod boolean spellings, improve field/archive errors and remove duplicate API findings and kit demo pages.
