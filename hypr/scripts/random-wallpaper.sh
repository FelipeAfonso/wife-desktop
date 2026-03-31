#!/usr/bin/env bash
# Pick a random wallpaper and apply it with awww + wallust
# Used on startup by hyprland.conf

# Seed RANDOM from /dev/urandom so startup doesn't repeat the same pick
RANDOM=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')

WALLPAPER_DIR="$HOME/media/wallpapers"
CACHE_FILE="$HOME/.cache/current-wallpaper-path"

# Collect image files
shopt -s nullglob
images=("$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,bmp,gif})
shopt -u nullglob

# Fall back to a default if the directory is empty or missing
if [ ${#images[@]} -eq 0 ]; then
    selected="/home/felipe/media/wallpapers/autumn.jpg"
else
    selected="${images[RANDOM % ${#images[@]}]}"
fi

# Save for persistence
echo "$selected" > "$CACHE_FILE"

# Apply wallpaper
awww img "$selected" \
    --transition-type grow \
    --transition-pos "0.5 0.5" \
    --transition-duration 2 \
    --transition-fps 60

# Generate colorscheme and apply to all apps
wallust run "$selected"
~/.config/hypr/scripts/apply-theme.sh
