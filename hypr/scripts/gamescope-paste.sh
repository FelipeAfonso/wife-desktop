#!/usr/bin/env bash
# Paste the Wayland clipboard into a Gamescope nested X11 session.
#
# Identifies the right Gamescope session by matching a process inside it
# (default: Wow.exe) and reading that process's DISPLAY env var. This is
# more robust than "first child of first gamescope-wl", which breaks the
# moment you have more than one Gamescope running.
#
# Usage: gamescope-paste.sh [pattern]
#   pattern: pgrep -f regex of the app inside the target Gamescope.
#            Defaults to Wow.exe.

set -u

pattern="${1:-Wow\.exe}"

for pid in $(pgrep -if -- "$pattern" 2>/dev/null); do
  display=$(tr '\0' '\n' < /proc/"$pid"/environ 2>/dev/null \
            | grep '^DISPLAY=' | cut -d= -f2)
  if [ -n "$display" ]; then
    wl-paste --no-newline | DISPLAY="$display" xclip -selection clipboard
    exit 0
  fi
done

notify-send "Gamescope paste" "No process matching '$pattern' with DISPLAY set" 2>/dev/null
exit 1
