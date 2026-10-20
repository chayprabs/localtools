"""Black-box review regressions against the installed artifact, stdlib only."""
import concurrent.futures
import io
import json
import os
import time
import urllib.error
import urllib.request
import uuid
import zipfile

base = "http://127.0.0.1:" + os.environ.get("PORT", "47133")


def post(fields=None, path="/api/render", plain=None, file=None):
    if plain is None:
        boundary = "latex-check-" + uuid.uuid4().hex
        body = b"".join((f'--{boundary}\r\nContent-Disposition: form-data; name="{key}"\r\n\r\n{value}\r\n').encode() for key, value in (fields or {}).items())
        if file:
            body += (f'--{boundary}\r\nContent-Disposition: form-data; name="file"; filename="{file[0]}"\r\nContent-Type: text/plain\r\n\r\n{file[1]}\r\n').encode()
        body += f"--{boundary}--\r\n".encode()
        content_type = "multipart/form-data; boundary=" + boundary
    else:
        body, content_type = plain.encode(), "text/plain"
    request = urllib.request.Request(base + path, data=body, headers={"Content-Type": content_type})
    try:
        response = urllib.request.urlopen(request, timeout=45)
    except urllib.error.HTTPError as error:
        response = error
    with response:
        return response.code, response.read(), response.headers


for _ in range(2):
    for name, code in [("sum", "2211"), ("int", "222B"), ("prod", "220F"), ("rarr", "2192"), ("ell", "2113")]:
        status, body, _headers = post({"math": f"<math><mo>&{name};</mo></math>", "input": "mathml"})
        assert status == 200 and f"&#x{code};" in json.loads(body)["mathml"], (status, body[:200])
unsafe = '<math><mrow onmouseover="alert(1)" style="background:url(http://example.invalid)" xlink:href="javascript:alert(1)"><mi href="javascript:alert(1)">x</mi><mglyph src="file:///example" width="1em" height="1em"/></mrow></math>'
for output in ["json", "svg", "mathml", "png"]:
    status, body, _headers = post({"math": unsafe, "input": "mathml", "format": output})
    assert status == 200, (status, body[:200])
    if output == "png":
        assert body.startswith(b"\x89PNG\r\n\x1a\n")
    else:
        assert not any(value in body for value in [b"onmouseover", b"javascript:", b"example.invalid", b"file://"])
status, body, _headers = post({"math": r"\tag{1.2} E=mc^2", "format": "png"})
assert status == 422 and "tagged/numbered" in json.loads(body)["error"]
status, body, _headers = post({"math": r"\begin{multline}a+b\\c+d\end{multline}"})
assert status == 200 and json.loads(body)["widthEx"] < 30
paper = "\\newcommand{\\vect}[1]{%\n \\mathbf{#1}}\n$x$ and $\\vect{v}$"
status, body, _headers = post({"split": "document"}, path="/api/batch", file=("paper.tex", paper))
assert status == 200, (status, body[:200])
with zipfile.ZipFile(io.BytesIO(body)) as archive:
    manifest = json.loads(archive.read("manifest.json"))
    assert manifest["count"] == 2 and manifest["failed"] == 0, manifest
print("installed: warm entities, sanitized exports/PNG, tagged refusal, compact multline, balanced macros PASS")

start = time.monotonic()
pending_math = ("xy " * 87382)[:262144]
with concurrent.futures.ThreadPoolExecutor(max_workers=1) as pool:
    future = pool.submit(post, {"math": pending_math})
    time.sleep(0.2)
    health_start = time.monotonic()
    with urllib.request.urlopen(base + "/api/health", timeout=3) as response:
        assert json.load(response)["ok"]
    assert time.monotonic() - health_start < 3
    status, body, _headers = future.result()
assert status == 200, (status, body[:200])
result = json.loads(body)
assert result["fontCache"] == "local" and not result["speech"]
assert "Speech omitted" in " ".join(result["warnings"]) and "Glyph reuse" in " ".join(result["warnings"])
assert "<desc>" in result["svg"] and "<svg" in result["svg"]
print(f"installed: exact262144 source bytes -> JSON with actual glyph cache/speech notice, healthy server ({time.monotonic()-start:.2f}s) PASS")

status, body, _headers = post({"math": "x" * (17 << 20)})
assert status == 413 and "upload too large" in json.loads(body)["error"], (status, body[:200])
print("installed: real urllib17MiB Connection: close -> complete JSON413 PASS")

ids = ["verify-" + uuid.uuid4().hex for _ in range(24)]
with concurrent.futures.ThreadPoolExecutor(max_workers=24) as pool:
    futures = [pool.submit(post, {"math": r"\text{" + "x" * 1200 + "}", "format": "png", "scale": "16", "job": job}) for job in ids]
    try:
        time.sleep(0.2)
        status, body, _headers = post({"math": "x" * (2 << 20)})
        assert status == 503 and "busy" in json.loads(body)["error"], (status, body[:200])
        with urllib.request.urlopen(base + "/api/health", timeout=3) as response:
            assert json.load(response)["ok"]
        print("installed: real urllib2MiB Connection: close -> complete JSON503; responsive health PASS")
    finally:
        for job in ids:
            post(path="/api/cancel", plain=job)
        for future in futures:
            future.result(timeout=45)
