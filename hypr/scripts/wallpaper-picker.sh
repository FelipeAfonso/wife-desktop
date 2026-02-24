#!/usr/bin/env bash
# Wallpaper picker — browse ~/Documents/wallpapers/ in rofi, apply with swww + wallust

WALLPAPER_DIR="$HOME/Documents/wallpapers"
CACHE_FILE="$HOME/.cache/current-wallpaper-path"
RANDOM_LABEL="Random"

# Ensure the wallpapers directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Picker" "Directory not found: $WALLPAPER_DIR\nCreate it and add some images." -u critical
    exit 1
fi

# Collect image files
shopt -s nullglob
images=("$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,bmp,gif})
shopt -u nullglob

if [ ${#images[@]} -eq 0 ]; then
    notify-send "Wallpaper Picker" "No images found in $WALLPAPER_DIR" -u critical
    exit 1
fi

# Build rofi input — random option first, then all images with previews
input="${RANDOM_LABEL}\0icon\x1fdice\n"
for img in "${images[@]}"; do
    filename=$(basename "$img")
    input+="${filename}\0icon\x1f${img}\n"
done

# Launch rofi picker
chosen=$(echo -en "$input" | rofi -dmenu \
    -theme "$HOME/.config/rofi/wallpaper-picker.rasi" \
    -p "Wallpaper" \
    -show-icons \
    -i)

# Exit if nothing was selected
[ -z "$chosen" ] && exit 0

# Handle random selection
if [ "$chosen" = "$RANDOM_LABEL" ]; then
    selected="${images[RANDOM % ${#images[@]}]}"
else
    selected="$WALLPAPER_DIR/$chosen"
fi

if [ ! -f "$selected" ]; then
    notify-send "Wallpaper Picker" "File not found: $selected" -u critical
    exit 1
fi

# Save selected wallpaper path for persistence
echo "$selected" > "$CACHE_FILE"

# Apply wallpaper with swww (smooth transition)
swww img "$selected" \
    --transition-type grow \
    --transition-pos "$(hyprctl cursorpos)" \
    --transition-duration 2 \
    --transition-fps 60

# Generate colorscheme with wallust
wallust run "$selected"

# Apply theme to all running applications
~/.config/hypr/scripts/apply-theme.sh

notify-send "Wallpaper Picker" "Applied: $(basename "$selected")" -t 3000
