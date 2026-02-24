#!/usr/bin/env bash
# Apply wallust-generated theme to all running applications
# Called by wallpaper-picker.sh after wallust generates new colors
# Can also be called standalone to re-apply the current theme

# --- Hyprland ---
# Border colors are sourced from hyprland-colors.conf via hyprland.conf
hyprctl reload

# --- Waybar ---
# Kill and restart to pick up new colors.css
pkill waybar
sleep 0.3
waybar &
disown

# --- Dunst ---
# Restart to pick up new dunstrc
pkill dunst
sleep 0.2
dunst &
disown

# --- Ghostty ---
# Ghostty watches its config for changes — update theme reference
# The template writes directly to ~/.config/ghostty/themes/pywal
# Ghostty auto-reloads when it detects the theme file changed

# --- Tmux ---
# Reload tmux colors in all running servers
tmux source-file ~/.config/tmux/tmux-colors.conf 2>/dev/null

# --- Neovim ---
# neopywal.nvim reads from ~/.cache/wallust/colors_neopywal.vim
# Send a command to all running neovim instances to reload colorscheme
for addr in /run/user/$(id -u)/nvim.*.0 /tmp/nvim.*/0; do
    [ -S "$addr" ] && nvim --server "$addr" --remote-send ':colorscheme neopywal<CR>' 2>/dev/null &
done
