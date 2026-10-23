#!/usr/bin/env bash
# Wallpaper picker: browse ~/Imagens/wallpapers in a rofi image grid and hand
# the pick to Noctalia. Noctalia owns the transition, the palette and every
# theme template; this script only chooses the file. Copied from miskatonic's
# picker minus awww and wallust.
set -u

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Imagens/wallpapers}"
THEME="$HOME/.config/rofi/wallpaper-picker.rasi"
RANDOM_LABEL="Aleatório"

# Seed RANDOM from /dev/urandom
RANDOM=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Papel de parede" "Pasta não encontrada: $WALLPAPER_DIR" -u critical
    exit 1
fi

shopt -s nullglob
images=("$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,bmp,gif,JPG,JPEG,PNG})
shopt -u nullglob

if [ ${#images[@]} -eq 0 ]; then
    notify-send "Papel de parede" "Nenhuma imagem em $WALLPAPER_DIR" -u critical
    exit 1
fi

# Paint rofi with Noctalia's current palette. The hyprland template writes
# ~/.config/hypr/noctalia.lua with lines like: local primary = "rgb(7a67e4)"
theme_colors=""
palette="$HOME/.config/hypr/noctalia.lua"
if [ -r "$palette" ]; then
    color() { sed -nE "s/^local $1 = \"rgb\(([0-9a-fA-F]{6})\)\".*/#\1/p" "$palette" | head -1; }
    bg=$(color surface); fg=$(color on_surface); ac=$(color primary); ac2=$(color secondary)
    if [ -n "$bg" ] && [ -n "$fg" ] && [ -n "$ac" ] && [ -n "$ac2" ]; then
        theme_colors="* { background: $bg; foreground: $fg; accent: $ac; accent2: $ac2; }"
    fi
fi

# rofi input: random first, then every image with itself as the icon
input="${RANDOM_LABEL}\0icon\x1fpreferences-desktop-wallpaper\n"
for img in "${images[@]}"; do
    input+="$(basename "$img")\0icon\x1f${img}\n"
done

chosen=$(echo -en "$input" | rofi -dmenu \
    -theme "$THEME" \
    ${theme_colors:+-theme-str "$theme_colors"} \
    -p "Papel de parede" \
    -show-icons \
    -i)

[ -z "$chosen" ] && exit 0

if [ "$chosen" = "$RANDOM_LABEL" ]; then
    selected="${images[RANDOM % ${#images[@]}]}"
else
    selected="$WALLPAPER_DIR/$chosen"
fi

if [ ! -f "$selected" ]; then
    notify-send "Papel de parede" "Arquivo não encontrado: $selected" -u critical
    exit 1
fi

# Noctalia applies it to every monitor, persists it, regenerates the theme
# templates and (with greeter sync on) the login screen.
if noctalia msg wallpaper-set "$selected" >/dev/null; then
    notify-send "Papel de parede" "$(basename "$selected")" -t 3000
else
    notify-send "Papel de parede" "Noctalia não aceitou $(basename "$selected")" -u critical
    exit 1
fi
