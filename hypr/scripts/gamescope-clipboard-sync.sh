#!/usr/bin/env bash
# Syncs the Wayland clipboard into Gamescope's nested X11 clipboard.
#
# Gamescope creates XWayland for games. xclip forks to background to own
# the X11 selection and serve paste requests. On each Wayland clipboard
# change we kill the old xclip via a pidfile and start a new one.
#
# Important: DISPLAY must NOT be exported globally or wl-paste breaks.
# We only set DISPLAY inline for xclip commands.

find_gamescope_display() {
  local gamescope_pid
  gamescope_pid=$(pgrep -x gamescope-wl 2>/dev/null | head -1)
  [ -z "$gamescope_pid" ] && return 1

  for pid in $(pgrep -P "$gamescope_pid" 2>/dev/null); do
    local display
    display=$(tr '\0' '\n' < /proc/"$pid"/environ 2>/dev/null | grep '^DISPLAY=' | cut -d= -f2)
    if [ -n "$display" ]; then
      echo "$display"
      return 0
    fi
  done
  return 1
}

echo "Waiting for Gamescope..."
while true; do
  GS_DISPLAY=$(find_gamescope_display)
  if [ -n "$GS_DISPLAY" ]; then
    echo "Found Gamescope nested X11 on DISPLAY=$GS_DISPLAY"
    break
  fi
  sleep 2
done

PIDFILE="/tmp/gamescope-xclip.pid"
HASHFILE="/tmp/gamescope-clip-hash"

cleanup() {
  [ -f "$PIDFILE" ] && kill "$(cat "$PIDFILE")" 2>/dev/null
  rm -f "$PIDFILE" "$HASHFILE"
}
trap cleanup EXIT INT TERM

echo "Syncing Wayland clipboard -> Gamescope X11 ($GS_DISPLAY)"

while read -r _; do
  content=$(wl-paste --no-newline 2>/dev/null) || continue
  [ -z "$content" ] && continue

  hash=$(echo -n "$content" | md5sum | cut -d' ' -f1)
  last=$(cat "$HASHFILE" 2>/dev/null)
  [ "$hash" = "$last" ] && continue
  echo -n "$hash" > "$HASHFILE"

  # Kill previous xclip by its pid
  [ -f "$PIDFILE" ] && kill "$(cat "$PIDFILE")" 2>/dev/null
  sleep 0.05

  echo -n "$content" | DISPLAY="$GS_DISPLAY" xclip -selection clipboard &
  echo $! > "$PIDFILE"

  echo "Synced: ${content:0:60}..."
done < <(wl-paste --watch echo)
