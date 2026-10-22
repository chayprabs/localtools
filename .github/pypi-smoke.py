"""Exercise the exact PyPI/pipx installation using the public smoke fixture."""
import json
import os
from pathlib import Path
import subprocess
import sys
import time
import urllib.request
import uuid

slug, version, entry = sys.argv[1:]
root = Path(slug)
tool = json.loads((root / 'tool.json').read_text())
assert subprocess.check_output([entry, '--version'], text=True).strip() == version
for action, command in [('update', 'upgrade'), ('uninstall', 'uninstall')]:
    output = subprocess.check_output([entry, action], text=True, timeout=20)
    assert f'pipx {command} localtools-{slug}' in output, output
spec = json.loads((root / 'smoke/smoke.json').read_text())
boundary = uuid.uuid4().hex
parts = []
for name, value in spec['fields'].items():
    parts.append(f'--{boundary}\r\nContent-Disposition: form-data; name="{name}"\r\n\r\n{value}\r\n'.encode())
for name, filename in spec['files'].items():
    parts.append(f'--{boundary}\r\nContent-Disposition: form-data; name="{name}"; filename="{filename}"\r\nContent-Type: application/octet-stream\r\n\r\n'.encode() + (root / 'smoke' / filename).read_bytes() + b'\r\n')
body = b''.join(parts) + f'--{boundary}--\r\n'.encode()
url = f'http://127.0.0.1:{tool["port"]}'
with open('pypi-server.log', 'w') as log:
    server = subprocess.Popen([entry, '--no-open'], stdout=log, stderr=subprocess.STDOUT,
                              env={**os.environ, 'LOCALTOOLS_NO_OPEN': '1'})
    try:
        for attempt in range(90):
            try:
                with urllib.request.urlopen(url + '/api/health', timeout=1) as response:
                    health = json.load(response)
                assert health['tool'] == slug and health['version'] == version, health
                break
            except OSError:
                if server.poll() is not None:
                    raise RuntimeError('PyPI server exited; see pypi-server.log')
                time.sleep(1)
        else:
            raise RuntimeError('PyPI server did not become healthy')
        request = urllib.request.Request(url + spec['path'], data=body,
                  headers={'Content-Type': f'multipart/form-data; boundary={boundary}'})
        with urllib.request.urlopen(request, timeout=180) as response:
            result = response.read()
        assert spec['expect'].encode() in result, result[:300]
        print(f'PyPI {slug} {version}: exact version, pipx guards, health and real smoke PASS ({len(result)} bytes)')
    finally:
        if os.name == 'nt':
            subprocess.run(['taskkill', '/PID', str(server.pid), '/T', '/F'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        else:
            server.terminate()
        try:
            server.wait(timeout=10)
        except subprocess.TimeoutExpired:
            server.kill()
            server.wait()
