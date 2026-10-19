"""Black-box regressions against the installed artifact; stdlib, real urllib Connection: close requests."""
import concurrent.futures
import json
import os
import struct
import time
import urllib.error
import urllib.request
import uuid
import zlib

base = "http://127.0.0.1:" + os.environ.get("PORT", "47128")


def post(fields=None, files=None, path="/api/render", plain=None):
    if plain is not None:
        body, content_type = plain.encode(), "text/plain"
    else:
        boundary = "og-check-" + uuid.uuid4().hex
        parts = []
        for key, value in (fields or {}).items():
            parts.append((f'--{boundary}\r\nContent-Disposition: form-data; name="{key}"\r\n\r\n{value}\r\n').encode())
        for key, (name, data) in (files or {}).items():
            parts += [(f'--{boundary}\r\nContent-Disposition: form-data; name="{key}"; filename="{name}"\r\nContent-Type: application/octet-stream\r\n\r\n').encode(), data, b"\r\n"]
        body = b"".join(parts) + f"--{boundary}--\r\n".encode()
        content_type = "multipart/form-data; boundary=" + boundary
    request = urllib.request.Request(base + path, data=body, headers={"Content-Type": content_type})
    try:
        response = urllib.request.urlopen(request, timeout=35)
    except urllib.error.HTTPError as error:
        response = error
    with response:
        return response.code, response.read()


def chunk(kind, data):
    return struct.pack(">I", len(data)) + kind + data + struct.pack(">I", zlib.crc32(kind + data))


png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", 64, 64, 8, 6, 0, 0, 0))
png += chunk(b"IDAT", zlib.compress((b"\0" + bytes([213, 67, 103, 255]) * 64) * 64)) + chunk(b"IEND", b"")
metadata = b"Comment\0" + b"x" * ((10 << 20) - len(png) - 12 - 8)
maximum = png[:-12] + chunk(b"tEXt", metadata) + png[-12:]
assert len(maximum) == 10 << 20
status, body = post({"template": "launch", "title": "Installed artifact maximum image"}, {"backgroundImage": ("ten.png", maximum)})
assert status == 200, (status, body[:200])
assert body[:8] == b"\x89PNG\r\n\x1a\n" and struct.unpack(">II", body[16:24]) == (1200, 630)
print("installed artifact: exact 10 MiB PNG background PASS")

bomb = '<img src="data:image/webp;base64,UklGRh4AAABXRUJQVlA4TBEAAAAvf/6fDwdQ5CrUo/+BiOh/AAA=" width="200" height="200"/>'
start = time.monotonic()
status, body = post({"markup": bomb})
assert status == 413 and "25 megapixels" in json.loads(body)["error"], (status, body[:200])
assert time.monotonic() - start < 10
print("installed artifact: inline WebP bomb rejected before decoding PASS")

status, body = post(files={"image": ("huge.png", bytes(70 << 20))})
assert status == 413 and "upload too large" in json.loads(body)["error"], (status, body[:200])
print("installed artifact: urllib 70 MiB Connection: close -> complete JSON 413 PASS")

ids = ["verify-" + uuid.uuid4().hex for _ in range(10)]
with concurrent.futures.ThreadPoolExecutor(max_workers=10) as pool:
    futures = [pool.submit(post, {"job": job, "size": "4096x4096", "format": "jpeg", "rowsText": json.dumps([{"title": "Busy"}] * 500)}, path="/api/batch") for job in ids]
    try:
        time.sleep(1)
        status, body = post(files={"image": ("busy.png", bytes(8 << 20))})
        assert status == 503 and "busy" in json.loads(body)["error"], (status, body[:200])
        with urllib.request.urlopen(base + "/api/health", timeout=2) as response:
            assert json.load(response)["ok"] is True
        print("installed artifact: urllib 8 MiB Connection: close -> complete JSON 503; health responsive PASS")
    finally:
        for job in ids:
            post(path="/api/cancel", plain=job)
        for future in futures:
            future.result(timeout=10)
