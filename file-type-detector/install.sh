#!/usr/bin/env bash
# localtools installer for File Type Detector (file-type-detector 1.0.0). macOS / Linux, no sudo.
# Usage: curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/file-type-detector/install.sh | bash
# Re-running updates. LOCALTOOLS_NO_OPEN=1 skips launching the tool afterwards.
set -euo pipefail

SLUG='file-type-detector'; NAME='File Type Detector'; VERSION='1.0.0'; PORT='47101'; KIND='bin'; IMAGE=''
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

URL=''; SHA=''
case "$OS-$ARCH" in
  macos-arm64) URL='https://github.com/chayprabs/localtools/releases/download/file-type-detector-v1.0.0/file-type-detector-1.0.0-macos-arm64.zip'; SHA='0d6ee4749ef2106041f329dc08de122b3b4c0f6cc9ce21f30248ae633099fe64' ;;
  macos-x64) URL='https://github.com/chayprabs/localtools/releases/download/file-type-detector-v1.0.0/file-type-detector-1.0.0-macos-x64.zip'; SHA='69671ccb4b04601121b60dbe86511a06d52b1f159c18102d474cce6f92efe4c6' ;;
  linux-x64) URL='https://github.com/chayprabs/localtools/releases/download/file-type-detector-v1.0.0/file-type-detector-1.0.0-linux-x64.zip'; SHA='2d601ba20dd99410dcd378e18185e4ba2415a7569a5541ef1ea8169c35b3fecc' ;;
  linux-arm64) URL='https://github.com/chayprabs/localtools/releases/download/file-type-detector-v1.0.0/file-type-detector-1.0.0-linux-arm64.zip'; SHA='a6a2c04df92dd99cfdb036e6ea9858be2e6a9ebb01a8037d0850d8be89aaaf6f' ;;
esac

if [ "$KIND" = docker ]; then
  command -v docker >/dev/null 2>&1 || die "$NAME needs Docker. Install Docker (macOS: https://docs.docker.com/desktop/setup/install/mac-install/ ; Linux: https://docs.docker.com/engine/install/), start it, then run this command again."
  docker info >/dev/null 2>&1 || die "Docker is installed but the daemon is not reachable. Start Docker (Desktop app, or 'sudo systemctl start docker' and add yourself to the docker group), then run this command again."
elif [ -z "$URL" ]; then
  die "no $NAME build for $OS-$ARCH yet"
fi

# Stop a running copy so the update takes effect.
if command -v pkill >/dev/null 2>&1; then pkill -f "($DIR/|$BIN/$CMD)" 2>/dev/null || true; fi

mkdir -p "$ROOT" "$BIN"
rm -rf "$DIR"
mkdir -p "$DIR"

if [ "$KIND" = docker ]; then
  docker rm -f "$CMD" >/dev/null 2>&1 || true
  say "pulling $IMAGE:$VERSION"
  docker pull "$IMAGE:$VERSION"
  cat > "$DIR/$CMD" <<EOF
#!/usr/bin/env bash
# serve (default) runs the container and opens the browser; anything else goes to the tool CLI.
set -euo pipefail
case "\${1:-serve}" in
  update) export LOCALTOOLS_NO_OPEN=1; exec bash -c "\$(curl -fsSL $BASE/install.sh)" ;;
  uninstall) exec bash -c "\$(curl -fsSL $BASE/uninstall.sh)" ;;
  serve|--no-open|--port)
    if [[ " \$* " != *" --no-open "* && "\${LOCALTOOLS_NO_OPEN:-}" != 1 ]]; then
      ( for _ in \$(seq 60); do
          if curl -fs http://127.0.0.1:$PORT/api/health >/dev/null 2>&1; then
            if command -v open >/dev/null 2>&1; then open http://127.0.0.1:$PORT/; else xdg-open http://127.0.0.1:$PORT/ >/dev/null 2>&1 || true; fi
            break
          fi; sleep 1
        done ) &
    fi
    echo "$CMD $VERSION running at http://127.0.0.1:$PORT  (Ctrl+C to stop)"
    exec docker run --rm --name $CMD -p 127.0.0.1:$PORT:$PORT $IMAGE:$VERSION serve --no-open ;;
  *) exec docker run --rm -i -v "\$PWD:/work" -w /work $IMAGE:$VERSION "\$@" ;;
esac
EOF
else
  command -v curl >/dev/null 2>&1 || die "curl is required"
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  ZIP="$TMP/$SLUG.zip"
  say "downloading $NAME $VERSION ($OS-$ARCH)"
  curl -fsSL "$URL" -o "$ZIP"
  if command -v sha256sum >/dev/null 2>&1; then GOT="$(sha256sum "$ZIP" | cut -d' ' -f1)"; else GOT="$(shasum -a 256 "$ZIP" | cut -d' ' -f1)"; fi
  [ "$GOT" = "$SHA" ] || die "checksum mismatch for $URL (expected $SHA, got $GOT); nothing was installed"
  if command -v unzip >/dev/null 2>&1; then unzip -qo "$ZIP" -d "$DIR"
  elif command -v bsdtar >/dev/null 2>&1; then bsdtar -xf "$ZIP" -C "$DIR"
  elif command -v python3 >/dev/null 2>&1; then python3 -c 'import sys,zipfile; zipfile.ZipFile(sys.argv[1]).extractall(sys.argv[2])' "$ZIP" "$DIR"
  else die "need unzip, bsdtar or python3 to extract the download"; fi
fi

ENTRY="$DIR/$CMD"
[ -f "$ENTRY" ] || die "release has no $CMD at its root"
chmod +x "$ENTRY"
if [ "$OS" = macos ]; then xattr -dr com.apple.quarantine "$DIR" 2>/dev/null || true; fi
echo "$VERSION $(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$DIR/installed.txt"

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
