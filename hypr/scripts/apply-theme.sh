#!/usr/bin/env bash
# Apply the wallust-generated palette to every running app.
# Called by wallpaper-picker.sh / restore-wallpaper.sh; safe to run by hand.

# Hyprland: border colors come from hyprland-colors.lua
hyprctl reload

# Waybar: restart to pick up colors.css
pkill waybar
sleep 0.3
waybar &
disown

# Dunst: restart to pick up dunstrc
pkill dunst
sleep 0.2
dunst &
disown

# Ghostty watches ~/.config/ghostty/themes/pywal and reloads on its own.
