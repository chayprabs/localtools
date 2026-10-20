#!/usr/bin/env bash
# localtools installer for DOCX Compare (docx-compare 1.0.0). macOS / Linux, no sudo.
# Usage: curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/install.sh | bash
# Re-running updates. LOCALTOOLS_NO_OPEN=1 skips launching the tool afterwards.
set -euo pipefail

SLUG='docx-compare'; NAME='DOCX Compare'; VERSION='1.0.0'; PORT='47134'; KIND='bin'; IMAGE=''
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

if [ "$SLUG" = exif-remover ]; then
  command -v perl >/dev/null 2>&1 || die "EXIF Remover needs Perl 5 on PATH. Provide a local Perl runtime, then run this command again."
fi

URL=''; SHA=''
case "$OS-$ARCH" in
  linux-arm64) URL='https://github.com/chayprabs/localtools/releases/download/docx-compare-v1.0.0/docx-compare-1.0.0-linux-arm64.zip'; SHA='16090290f6c7a533a7096781a471bcdf06ca31b251c931d95eca693a7ca835a0' ;;
  linux-x64) URL='https://github.com/chayprabs/localtools/releases/download/docx-compare-v1.0.0/docx-compare-1.0.0-linux-x64.zip'; SHA='f98b746d4a95343a80a2731b077e9964892ff0a17a5c6077b0c14b862cda0983' ;;
  macos-arm64) URL='https://github.com/chayprabs/localtools/releases/download/docx-compare-v1.0.0/docx-compare-1.0.0-macos-arm64.zip'; SHA='4bd20787860b040fd6c85dc78ab09b5a5d421a11efd7356e76282c6256504924' ;;
  macos-x64) URL='https://github.com/chayprabs/localtools/releases/download/docx-compare-v1.0.0/docx-compare-1.0.0-macos-x64.zip'; SHA='db430b3eab1b7fb182d24845742cacdd9afb8d1deab1149a7baba3d26e2a54db' ;;
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
  cat > "$STAGE/$CMD" <<EOF
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
[ "$KIND" = docker ] && { docker rm -f "$CMD" >/dev/null 2>&1 || true; }
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
