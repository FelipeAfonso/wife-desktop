#!/usr/bin/env bash
# Build node-pty's native module for linux-x64 when the shipped package lacks it.
#
# Upstream t3 ships node-pty prebuilds for darwin-{arm64,x64} and win32-{arm64,x64}
# only. On Linux the loader looks in build/Release, build/Debug, then
# prebuilds/linux-x64 -- finds nothing -- and the server dies at startup with
# NodePtyModuleLoadError. Every t3 update unpacks a fresh node_modules, so this
# reruns as ExecStartPre and rebuilds whatever version is currently active.
#
# Exits 0 even on build failure: systemd should surface the real service error
# rather than a confusing ExecStartPre failure.
set -uo pipefail

T3_HOME="${T3CODE_HOME:-$HOME/.t3}"
VERSIONS_DIR="$T3_HOME/runtime/versions"
STATE_FILE="$T3_HOME/runtime/service-state.json"

log() { printf '[t3-rebuild-node-pty] %s\n' "$*"; }

[ -d "$VERSIONS_DIR" ] || { log "no versions dir at $VERSIONS_DIR; nothing to do"; exit 0; }

# Prefer the active version; fall back to every installed version so a rollback
# or a fallback launch isn't left with a broken native module.
targets=()
if [ -r "$STATE_FILE" ] && command -v node >/dev/null 2>&1; then
  active="$(node -e '
    try {
      const s = require("fs").readFileSync(process.argv[1], "utf8");
      const v = JSON.parse(s).activeVersion;
      if (typeof v === "string" && v) process.stdout.write(v);
    } catch {}
  ' "$STATE_FILE" 2>/dev/null)"
  [ -n "${active:-}" ] && [ -d "$VERSIONS_DIR/$active" ] && targets=("$VERSIONS_DIR/$active")
fi
if [ ${#targets[@]} -eq 0 ]; then
  for d in "$VERSIONS_DIR"/*/; do [ -d "$d" ] && targets+=("${d%/}"); done
fi

for version_dir in "${targets[@]}"; do
  pty_dir="$version_dir/node_modules/node-pty"
  [ -d "$pty_dir" ] || continue

  # Same resolution order as node-pty's lib/utils.js loadNativeModule().
  if [ -f "$pty_dir/build/Release/pty.node" ] \
    || [ -f "$pty_dir/build/Debug/pty.node" ] \
    || [ -f "$pty_dir/prebuilds/linux-x64/pty.node" ]; then
    continue
  fi

  log "building node-pty for $(basename "$version_dir")"
  if ! command -v node-gyp >/dev/null 2>&1; then
    log "ERROR: node-gyp not found; install it (pacman -S node-gyp) to auto-repair"
    continue
  fi

  if (cd "$pty_dir" && node-gyp rebuild) >/tmp/t3-node-pty-build.log 2>&1; then
    log "built $pty_dir/build/Release/pty.node"
  else
    log "ERROR: build failed; see /tmp/t3-node-pty-build.log"
  fi
done

exit 0
