#!/usr/bin/env bash
# On login: re-apply the last chosen wallpaper and its palette. If none was
# ever chosen, pick a random one from the wallpaper dir. Cozy means the desk
# looks the same every morning; rotation is a keypress away (SUPER+W).

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_FILE="$HOME/.cache/current-wallpaper-path"

selected=""
if [ -r "$CACHE_FILE" ]; then
    selected="$(cat "$CACHE_FILE")"
    [ -f "$selected" ] || selected=""
fi

if [ -z "$selected" ]; then
    RANDOM=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
    shopt -s nullglob
    images=("$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,bmp,gif})
    shopt -u nullglob
    if [ ${#images[@]} -eq 0 ]; then
        notify-send "Wallpaper" "No images in $WALLPAPER_DIR; add some and press SUPER+W" -u low
        exit 0
    fi
    selected="${images[RANDOM % ${#images[@]}]}"
    echo "$selected" > "$CACHE_FILE"
fi

awww img "$selected" \
    --transition-type grow \
    --transition-pos "0.5 0.5" \
    --transition-duration 2 \
    --transition-fps 60

wallust run "$selected"
~/.config/hypr/scripts/apply-theme.sh
