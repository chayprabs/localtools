#!/usr/bin/env bash
# localtools uninstaller for PDF to Markdown (pdf-to-markdown). macOS / Linux.
# Usage: curl -fsSL https://raw.githubusercontent.com/chayprabs/localtools/main/pdf-to-markdown/uninstall.sh | bash
set -euo pipefail

SLUG='pdf-to-markdown'; NAME='PDF to Markdown'; KIND='py'; IMAGE=''
CMD="localtools-$SLUG"
ROOT="${LOCALTOOLS_HOME:-$HOME/.localtools}"
DIR="$ROOT/$SLUG"
BIN="$ROOT/bin"

if command -v pkill >/dev/null 2>&1; then pkill -f "($DIR/|$BIN/$CMD)" 2>/dev/null || true; fi
if [ "$KIND" = docker ] && command -v docker >/dev/null 2>&1; then
  docker rm -f "$CMD" >/dev/null 2>&1 || true
  docker images -q "$IMAGE" 2>/dev/null | xargs -r docker rmi -f >/dev/null 2>&1 || true
fi
rm -rf "$DIR" "$DIR".new-* "$DIR".old-* "$BIN/$CMD" "$HOME/Applications/localtools $NAME.app" "${XDG_DATA_HOME:-$HOME/.local/share}/applications/$CMD.desktop"

# Last localtools tool gone: drop bin dir and the PATH lines.
if [ -z "$(find "$ROOT" -mindepth 1 -maxdepth 1 -type d ! -name bin 2>/dev/null)" ]; then
  rm -rf "$BIN"
  rmdir "$ROOT" 2>/dev/null || true
  for rc in "$HOME/.profile" "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc" ] && grep -qs '# localtools$' "$rc"; then
      grep -v '# localtools$' "$rc" > "$rc.localtools.tmp" || true
      cat "$rc.localtools.tmp" > "$rc" && rm -f "$rc.localtools.tmp"
    fi
  done
fi
echo "localtools: uninstalled $NAME"
