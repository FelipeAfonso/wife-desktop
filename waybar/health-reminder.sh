#!/bin/bash
#
# Health Reminder — Waybar custom module + toggle daemon
#
# Usage:
#   health-reminder.sh            → output JSON status for Waybar (polled)
#   health-reminder.sh --toggle   → start/stop the reminder daemon
#   health-reminder.sh --daemon   → run the reminder loop (internal, do not call directly)
#
# Reminders:
#   Every 15 min — drink water
#   Every 20 min — look away for 20 seconds (20-20-20 rule)
#   Every 45 min — stretch
#

SCRIPT="$(realpath "$0")"
PIDFILE="/tmp/health-reminder.pid"
STATEFILE="/tmp/health-reminder.state"

# Notification IDs (for dunstify replace-on-update)
NOTIFY_WATER_ID=991001
NOTIFY_EYES_ID=991002
NOTIFY_STRETCH_ID=991003

# Intervals in seconds
WATER_INTERVAL=900    # 15 minutes
EYES_INTERVAL=1200    # 20 minutes
STRETCH_INTERVAL=2700 # 45 minutes

# ---------------------------------------------------------------------------
# Helper — check if daemon is alive
# ---------------------------------------------------------------------------
daemon_alive() {
    [ -f "$PIDFILE" ] || return 1
    local pid
    pid=$(cat "$PIDFILE" 2>/dev/null) || return 1
    [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null
}

# ---------------------------------------------------------------------------
# Daemon — runs as its own process, sending notifications on schedule
#   Launched by --toggle via: setsid bash $SCRIPT --daemon
#   This means $$ is the real PID of this process.
# ---------------------------------------------------------------------------
run_daemon() {
    # Write our real PID
    echo $$ > "$PIDFILE"

    # Clean up on exit
    trap 'rm -f "$PIDFILE"; echo "inactive" > "$STATEFILE"; pkill -RTMIN+8 waybar 2>/dev/null; exit 0' TERM INT HUP

    local elapsed=0
    local tick=1

    # Write initial state so the status poller can read start time
    echo "active $(date +%s)" > "$STATEFILE"

    # Signal waybar to refresh immediately
    pkill -RTMIN+8 waybar 2>/dev/null

    while true; do
        sleep "$tick"
        elapsed=$((elapsed + tick))

        # Water reminder — every 15 min
        if (( elapsed % WATER_INTERVAL == 0 )); then
            dunstify -r "$NOTIFY_WATER_ID" \
                     -u normal \
                     -i preferences-desktop-notification \
                     "💧 Drink Water" \
                     "Time to take a sip of water!"
        fi

        # Eye rest reminder — every 20 min
        if (( elapsed % EYES_INTERVAL == 0 )); then
            dunstify -r "$NOTIFY_EYES_ID" \
                     -u normal \
                     -i preferences-desktop-notification \
                     "👀 Rest Your Eyes" \
                     "Look at something 20 feet away for 20 seconds."
        fi

        # Stretch reminder — every 45 min
        if (( elapsed % STRETCH_INTERVAL == 0 )); then
            dunstify -r "$NOTIFY_STRETCH_ID" \
                     -u normal \
                     -i preferences-desktop-notification \
                     "🧘 Stretch Break" \
                     "Stand up and stretch for a minute!"
        fi
    done
}

# ---------------------------------------------------------------------------
# Toggle — start or stop the daemon
# ---------------------------------------------------------------------------
do_toggle() {
    if daemon_alive; then
        local pid
        pid=$(cat "$PIDFILE")
        kill "$pid" 2>/dev/null
        # The trap in the daemon handles cleanup, but ensure it's done:
        rm -f "$PIDFILE"
        echo "inactive" > "$STATEFILE"
        pkill -RTMIN+8 waybar 2>/dev/null
        return
    fi

    # Clean up any stale PID file
    rm -f "$PIDFILE"

    # Launch daemon as a fully detached process (new session, no terminal)
    setsid bash "$SCRIPT" --daemon </dev/null &>/dev/null &

    # Wait briefly for the daemon to write its PID file
    local i=0
    while [ ! -f "$PIDFILE" ] && [ "$i" -lt 20 ]; do
        sleep 0.05
        i=$((i + 1))
    done

    pkill -RTMIN+8 waybar 2>/dev/null
}

# ---------------------------------------------------------------------------
# Status — output JSON for Waybar to consume
# ---------------------------------------------------------------------------
print_status() {
    # Check if daemon is actually alive
    if [ -f "$PIDFILE" ] && ! daemon_alive; then
        # Process died unexpectedly — clean up
        rm -f "$PIDFILE"
        echo "inactive" > "$STATEFILE"
    fi

    if daemon_alive && [ -f "$STATEFILE" ]; then
        local state start_time now elapsed
        state=$(awk '{print $1}' "$STATEFILE")
        start_time=$(awk '{print $2}' "$STATEFILE")
        now=$(date +%s)
        elapsed=$(( now - start_time ))

        if [ "$state" = "active" ]; then
            # Calculate time remaining for each reminder
            local water_remaining eyes_remaining stretch_remaining

            water_remaining=$(( WATER_INTERVAL - (elapsed % WATER_INTERVAL) ))
            eyes_remaining=$(( EYES_INTERVAL - (elapsed % EYES_INTERVAL) ))
            stretch_remaining=$(( STRETCH_INTERVAL - (elapsed % STRETCH_INTERVAL) ))

            local water_min=$(( water_remaining / 60 ))
            local water_sec=$(( water_remaining % 60 ))
            local eyes_min=$(( eyes_remaining / 60 ))
            local eyes_sec=$(( eyes_remaining % 60 ))
            local stretch_min=$(( stretch_remaining / 60 ))
            local stretch_sec=$(( stretch_remaining % 60 ))

            local total_min=$(( elapsed / 60 ))

            printf '{"text":"💧","tooltip":"Health reminders: active (%dm)\\n💧 Water: %dm %ds\\n👀 Eyes: %dm %ds\\n🧘 Stretch: %dm %ds","class":"active"}\n' \
                "$total_min" \
                "$water_min" "$water_sec" \
                "$eyes_min" "$eyes_sec" \
                "$stretch_min" "$stretch_sec"
            return
        fi
    fi

    # Inactive / no state
    printf '{"text":"💧","tooltip":"Health reminders: off (click to start)","class":"inactive"}\n'
}

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
case "${1:-}" in
    --toggle) do_toggle ;;
    --daemon) run_daemon ;;
    *)        print_status ;;
esac
