"""Exercise installed Pandoc GUI packages, including process cleanup, using only Python's standard library."""
import concurrent.futures
import http.client
import json
import os
from pathlib import Path
import socket
import subprocess
import tempfile
import time
import urllib.error
import urllib.request


def body(text):
    boundary = "localtools-pandoc-package-verification"
    parts = []
    for key, value in {"text": text, "to": "html"}.items():
        parts.append(f'--{boundary}\r\nContent-Disposition: form-data; name="{key}"\r\n\r\n{value}\r\n')
    return ("".join(parts) + f"--{boundary}--\r\n").encode(), f"multipart/form-data; boundary={boundary}"


def children(pid):
    if os.name == "nt":
        code = f"Get-CimInstance Win32_Process -Filter 'ParentProcessId={pid}' | Select-Object -ExpandProperty ProcessId"
        out = subprocess.check_output(["powershell", "-NoProfile", "-Command", code], text=True)
    else:
        out = subprocess.run(["pgrep", "-P", str(pid)], capture_output=True, text=True).stdout
    return [int(p) for p in out.split()]


def alive(pid):
    if os.name == "nt":
        out = subprocess.check_output(["powershell", "-NoProfile", "-Command", f"Get-Process -Id {pid} -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id; exit 0"], text=True)
        return bool(out.strip())
    out = subprocess.run(["ps", "-o", "stat=", "-p", str(pid)], capture_output=True, text=True).stdout.strip()
    return bool(out) and not out.startswith("Z")


entry = Path(os.environ["LOCALTOOLS_VERIFY_ENTRY"]) if "LOCALTOOLS_VERIFY_ENTRY" in os.environ else Path.home() / ".localtools" / "pandoc-gui" / ("localtools-pandoc-gui.exe" if os.name == "nt" else "localtools-pandoc-gui")
assert entry.is_file(), entry
with tempfile.TemporaryDirectory(prefix="pandoc-public-verify-") as tmp:
    root = Path(tmp)
    sample = root / "sample.md"
    sample.write_text("# Package verification\n\nA **real** document with $a^2$.\n", encoding="utf-8")
    for ext, magic in {"html": b"<!DOCTYPE html>", "pdf": b"%PDF-", "docx": b"PK", "epub": b"PK"}.items():
        target = root / f"result.{ext}"
        subprocess.run([str(entry), "convert", str(sample), "-o", str(target)], check=True, timeout=30)
        assert target.read_bytes().startswith(magic), ext
    if os.name != "nt":
        link = root / "linked-tool"
        link.symlink_to(entry)
        subprocess.run([str(link), "convert", str(sample), "-o", str(root / "linked.pdf")], check=True, timeout=30)
        assert (root / "linked.pdf").read_bytes().startswith(b"%PDF-")
    print("4 packaged CLI formats + sidecar lookup passed", flush=True)
    sock = socket.socket()
    sock.bind(("127.0.0.1", 0))
    port = sock.getsockname()[1]
    sock.close()
    env = dict(os.environ, LOCALTOOLS_NO_OPEN="1", LOCALTOOLS_JOB_DEADLINE_MS="4000", TMP=tmp, TEMP=tmp, TMPDIR=tmp)
    log = open(root / "server.log", "wb")
    server = subprocess.Popen([str(entry), "--no-open", "--port", str(port)], env=env, stdout=log, stderr=log)
    base = f"http://127.0.0.1:{port}"
    try:
        for _ in range(100):
            try:
                with urllib.request.urlopen(base + "/api/health", timeout=1) as r:
                    assert json.load(r)["tool"] == "pandoc-gui"
                break
            except OSError:
                time.sleep(.1)
        else:
            raise AssertionError("server did not start")

        def post(text):
            data, content_type = body(text)
            req = urllib.request.Request(base + "/api/convert", data=data, headers={"Content-Type": content_type})
            try:
                with urllib.request.urlopen(req, timeout=12) as r:
                    return r.status, r.read()
            except urllib.error.HTTPError as e:
                return e.code, e.read()

        deep = ">" * 20000 + " x\n"
        with concurrent.futures.ThreadPoolExecutor(2) as pool:
            tasks = [pool.submit(post, text) for text in (deep, "[" * 20000 + "x" + "]" * 20000)]
            time.sleep(1)
            start = time.monotonic()
            with urllib.request.urlopen(base + "/api/health", timeout=1) as r:
                assert r.status == 200
            assert time.monotonic() - start < 1
            assert post("# Busy")[0] == 503
            assert [task.result()[0] for task in tasks] == [504, 504]
        assert post("# Still usable")[0] == 200
        data, content_type = body(deep)
        conn = http.client.HTTPConnection("127.0.0.1", port)
        conn.request("POST", "/api/convert", data, {"Content-Type": content_type})
        time.sleep(.5)
        conn.close()
        for _ in range(50):
            if not list(root.glob("localtools-pandoc-gui-*")):
                break
            time.sleep(.1)
        assert not list(root.glob("localtools-pandoc-gui-*")), "cancelled request left scratch folders"
        assert post("# Healthy after disconnect")[0] == 200
        print("deadline + overload + responsive health + disconnect cleanup passed", flush=True)
        with concurrent.futures.ThreadPoolExecutor(1) as pool:
            task = pool.submit(post, deep)
            time.sleep(.5)
            pids = children(server.pid)
            assert pids, "no engine process found"
            server.kill()
            server.wait(timeout=5)
            for _ in range(30):
                if not any(alive(pid) for pid in pids):
                    break
                time.sleep(.1)
            assert not any(alive(pid) for pid in pids), f"engine survived server exit: {pids}"
            try:
                task.result()
            except (OSError, http.client.HTTPException):
                pass
        print("parent-death cleanup passed", flush=True)
    finally:
        if server.poll() is None:
            server.kill()
        server.wait(timeout=5)
        log.close()
        print((root / "server.log").read_text(errors="replace"), flush=True)
