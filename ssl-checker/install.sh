#!/usr/bin/env bash
# localtools installer for SSL Checker (ssl-checker 1.0.1). macOS / Linux, no sudo.
# Usage: curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/ssl-checker/install.sh | bash
# Re-running updates. LOCALTOOLS_NO_OPEN=1 skips launching the tool afterwards.
set -euo pipefail

SLUG='ssl-checker'; NAME='SSL Checker'; VERSION='1.0.1'; PORT='47121'; KIND='bin'; IMAGE=''
CMD="localtools-$SLUG"
ROOT="${LOCALTOOLS_HOME:-$HOME/.localtools}"
DIR="$ROOT/$SLUG"
BIN="$ROOT/bin"
BASE="https://raw.githubusercontent.com/chayprabs/localtools/main/$SLUG"

say() { printf 'localtools: %s\n' "$*"; }
die() { printf 'localtools: error: %s\n' "$*" >&2; exit 1; }

case "$(uname -s)" in
  Darwin) OS=macos ;;
  Linux) OS=linux ;;
  *) die "unsupported OS $(uname -s); on Windows use: irm $BASE/install.ps1 | iex" ;;
esac
case "$(uname -m)" in
  arm64|aarch64) ARCH=arm64 ;;
  x86_64|amd64) ARCH=x64 ;;
  *) die "unsupported CPU $(uname -m)" ;;
esac
# A shell running under Rosetta reports x86_64 on Apple Silicon; prefer the native build.
if [ "$OS" = macos ] && [ "$(sysctl -n sysctl.proc_translated 2>/dev/null || echo 0)" = 1 ]; then ARCH=arm64; fi

if [ "$OS" = macos ] && [ "$KIND" != docker ]; then
  macos_version=$(sw_vers -productVersion) || die "could not determine macOS version; nothing was changed"
  [ "${macos_version%%.*}" -ge 12 ] || die "$NAME requires macOS 12 or later (found $macos_version); nothing was changed"
fi

if [ "$SLUG" = exif-remover ]; then
  command -v perl >/dev/null 2>&1 || die "EXIF Remover needs Perl 5 on PATH. Provide a local Perl runtime, then run this command again."
fi

URL=''; SHA=''
case "$OS-$ARCH" in
  linux-arm64) URL='https://github.com/chayprabs/localtools/releases/download/ssl-checker-v1.0.1/ssl-checker-1.0.1-linux-arm64.zip'; SHA='268ed5e3044bef0de70f7b13a6a7205f052e56350801cfaec896e40d8c5fd231' ;;
  linux-x64) URL='https://github.com/chayprabs/localtools/releases/download/ssl-checker-v1.0.1/ssl-checker-1.0.1-linux-x64.zip'; SHA='0a6ce4b6612763f716c740f1bc02744aad320e122b062c7dc33f8549905eb9cb' ;;
  macos-arm64) URL='https://github.com/chayprabs/localtools/releases/download/ssl-checker-v1.0.1/ssl-checker-1.0.1-macos-arm64.zip'; SHA='04456aa6d66a9a8fda77ee8a401f080a3505ffad17ff56035fd68c9ad0b44db5' ;;
  macos-x64) URL='https://github.com/chayprabs/localtools/releases/download/ssl-checker-v1.0.1/ssl-checker-1.0.1-macos-x64.zip'; SHA='3e48cb69b142992721d67541133eae471ce11439c509dd525aeab51323ccec89' ;;
esac

if [ "$KIND" = docker ]; then
  command -v docker >/dev/null 2>&1 || die "$NAME needs Docker. Install Docker (macOS: https://docs.docker.com/desktop/setup/install/mac-install/ ; Linux: https://docs.docker.com/engine/install/), start it, then run this command again."
  docker info >/dev/null 2>&1 || die "Docker is installed but the daemon is not reachable. Start Docker (Desktop app, or 'sudo systemctl start docker' and add yourself to the docker group), then run this command again."
elif [ -z "$URL" ]; then
  die "no $NAME build for $OS-$ARCH yet"
fi

mkdir -p "$ROOT" "$BIN"
# Build the new copy in a staging dir next to the install dir; the current install stays untouched until it is ready.
STAGE="$DIR.new-$$"; OLD="$DIR.old-$$"; TMP="$(mktemp -d)"
rm -rf "$DIR".new-* "$DIR".old-* 2>/dev/null || true
trap 'rm -rf "$TMP" "$STAGE"' EXIT
fail() {
  if [ -d "$DIR" ]; then die "$*; your current install in $DIR was left unchanged"; else die "$*; nothing was installed"; fi
}
mkdir -p "$STAGE"

if [ "$KIND" = docker ]; then
  say "pulling $IMAGE:$VERSION"
  docker pull "$IMAGE:$VERSION" || fail "docker pull $IMAGE:$VERSION failed"
  cat > "$STAGE/$CMD" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
slug='ssl-checker'; cmd="localtools-$slug"; image=':1.0.1'
self="${BASH_SOURCE[0]}"
while [ -L "$self" ]; do
  parent="$(cd -P "$(dirname "$self")" && pwd)"; self="$(readlink "$self")"
  [[ "$self" = /* ]] || self="$parent/$self"
done
dir="$(cd -P "$(dirname "$self")" && pwd)"; root="$(dirname "$dir")"
first="${1:-serve}"
case "$first" in
  update|uninstall)
    if [ ! -f "$dir/installed.txt" ] || [ ! -L "$root/bin/$cmd" ] || [ "$(readlink "$root/bin/$cmd")" != "$dir/$cmd" ]; then
      echo "$cmd was not installed by the localtools script; use your original package manager or docker pull $image"; exit 0
    fi
    export LOCALTOOLS_HOME="$root" LOCALTOOLS_NO_OPEN=1
    script=install; [ "$first" = uninstall ] && script=uninstall
    exec bash -c "$(curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/$slug/$script.sh)" ;;
esac
port="${LOCALTOOLS_PORT:-47121}"; no_open="${LOCALTOOLS_NO_OPEN:-}"
serve=false
case "$first" in serve|--no-open|--port|--port=*) serve=true;; esac
if $serve; then
  args=("$@"); [ "$first" = serve ] && args=("${args[@]:1}")
  for ((i=0;i<${#args[@]};i++)); do
    case "${args[i]}" in
      --port) i=$((i+1)); port="${args[i]:-}" ;;
      --port=*) port="${args[i]#*=}" ;;
      --no-open|--no-open=true) no_open=1 ;;
      *) echo "error: unknown serve option ${args[i]} (see --help)" >&2; exit 1 ;;
    esac
  done
  [[ "$port" =~ ^[0-9]+$ ]] && [ "$port" -ge 1 ] && [ "$port" -le 65535 ] || { echo 'error: --port must be 1 through 65535' >&2; exit 1; }
  url="http://127.0.0.1:$port"
  browser() { if command -v open >/dev/null 2>&1; then open "$url/"; else xdg-open "$url/" >/dev/null 2>&1 || true; fi; }
  own() { curl -fsS --max-time 1 "$url/api/health" 2>/dev/null | grep -q '"tool": *"'"$slug"'"'; }
  if own; then echo "$cmd already running at $url"; [ "$no_open" = 1 ] || browser; exit 0; fi
  if [ "$no_open" != 1 ]; then (for _ in $(seq 90); do if own; then browser; break; fi; sleep 1; done) & fi
  echo "$cmd 1.0.1 running at $url  (Ctrl+C to stop; choose --port N for another port)"
  exec docker run --rm --name "$cmd-$port" --label "localtools.install=$dir" --read-only --tmpfs /worktemp:rw,nosuid,nodev,size=384m,mode=1777 --cap-drop ALL --security-opt no-new-privileges -p "127.0.0.1:$port:$port" "$image" serve --no-open --port "$port"
fi
exec docker run --rm -i --network none --user "$(id -u):$(id -g)" --read-only --tmpfs /worktemp:rw,nosuid,nodev,size=384m,mode=1777 --cap-drop ALL --security-opt no-new-privileges -v "$PWD:/work" -w /work "$image" "$@"
EOF
else
  command -v curl >/dev/null 2>&1 || fail "curl is required"
  ZIP="$TMP/$SLUG.zip"
  say "downloading $NAME $VERSION ($OS-$ARCH)"
  curl -fsSL "$URL" -o "$ZIP" || fail "download of $URL failed"
  if command -v sha256sum >/dev/null 2>&1; then GOT="$(sha256sum "$ZIP" | cut -d' ' -f1)"; else GOT="$(shasum -a 256 "$ZIP" | cut -d' ' -f1)"; fi
  [ "$GOT" = "$SHA" ] || fail "checksum mismatch for $URL (expected $SHA, got $GOT)"
  if command -v unzip >/dev/null 2>&1; then unzip -qo "$ZIP" -d "$STAGE"
  elif command -v bsdtar >/dev/null 2>&1; then bsdtar -xf "$ZIP" -C "$STAGE"
  elif command -v python3 >/dev/null 2>&1; then python3 -c 'import sys,zipfile; zipfile.ZipFile(sys.argv[1]).extractall(sys.argv[2])' "$ZIP" "$STAGE"
  else fail "need unzip, bsdtar or python3 to extract the download"; fi || fail "could not extract $ZIP"
fi
[ -f "$STAGE/$CMD" ] || fail "release has no $CMD at its root"
chmod +x "$STAGE/$CMD"
echo "$VERSION $(date -u +%Y-%m-%dT%H:%M:%SZ) $$" > "$STAGE/installed.txt" # pid: re-installs in the same second still differ

# Swap: stop the running copy, move the old install aside, move the new one in, then delete the old one.
if command -v pkill >/dev/null 2>&1; then pkill -f "($DIR/|$BIN/$CMD)" 2>/dev/null || true; fi
if [ "$KIND" = docker ]; then
  while IFS= read -r id; do [ -z "$id" ] || docker rm -f "$id" >/dev/null 2>&1 || true; done < <(docker ps -aq --filter "label=localtools.install=$DIR")
fi
if [ -e "$DIR" ]; then mv "$DIR" "$OLD" || fail "could not move $DIR aside"; fi
if ! mv "$STAGE" "$DIR"; then
  [ -e "$OLD" ] && mv "$OLD" "$DIR"
  fail "could not move the new version into $DIR"
fi
rm -rf "$OLD"

ENTRY="$DIR/$CMD"
if [ "$OS" = macos ]; then xattr -dr com.apple.quarantine "$DIR" 2>/dev/null || true; fi

ln -sf "$ENTRY" "$BIN/$CMD"

# PATH: one marked line per rc file (zsh, the macOS default, does not read ~/.profile).
LINE="export PATH=\"$BIN:\$PATH\" # localtools"
RCS="$HOME/.profile"
[ -f "$HOME/.bashrc" ] && RCS="$RCS $HOME/.bashrc"
if [ -f "$HOME/.zshrc" ] || [ "$OS" = macos ]; then RCS="$RCS $HOME/.zshrc"; fi
for rc in $RCS; do
  grep -qs '# localtools$' "$rc" || printf '\n%s\n' "$LINE" >> "$rc"
done

# Launcher.
if [ "$OS" = macos ]; then
  APP="$HOME/Applications/localtools $NAME.app"
  rm -rf "$APP"
  mkdir -p "$APP/Contents/MacOS"
  printf '#!/bin/sh\nexec "%s"\n' "$ENTRY" > "$APP/Contents/MacOS/launcher"
  chmod +x "$APP/Contents/MacOS/launcher"
  cat > "$APP/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>$NAME</string>
<key>CFBundleDisplayName</key><string>$NAME</string>
<key>CFBundleIdentifier</key><string>com.localtools.$SLUG</string>
<key>CFBundleExecutable</key><string>launcher</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>$VERSION</string>
</dict></plist>
EOF
  LAUNCHER="$APP"
else
  APPS="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
  mkdir -p "$APPS"
  LAUNCHER="$APPS/$CMD.desktop"
  cat > "$LAUNCHER" <<EOF
[Desktop Entry]
Type=Application
Name=$NAME
Comment=localtools $NAME (runs locally, opens in your browser)
Exec="$ENTRY"
Terminal=false
Categories=Utility;
EOF
fi

say "installed $NAME $VERSION to $DIR"
cat <<EOF

  Open it:    $LAUNCHER   (or run: $CMD)
  In browser: http://127.0.0.1:$PORT
  Update:     $CMD update
  Uninstall:  $CMD uninstall
  New terminals have it on PATH; in this one run: export PATH="$BIN:\$PATH"

EOF

if [ "${LOCALTOOLS_NO_OPEN:-}" != 1 ]; then
  if command -v setsid >/dev/null 2>&1; then setsid "$ENTRY" >/dev/null 2>&1 < /dev/null &
  else nohup "$ENTRY" >/dev/null 2>&1 < /dev/null & fi
fi
