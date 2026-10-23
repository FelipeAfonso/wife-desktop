-- Hyprland default apps

TERMINAL     = "ghostty"
FILE_MANAGER = "dolphin"
BROWSER      = "firefox"
EDITOR       = "gnome-text-editor --new-window"
CALCULATOR   = "gnome-calculator"

-- Monitors (names from `hyprctl monitors`). Both are 4K at 60 Hz, scale 1.5.
-- MONITOR1 is the primary: workspace 1, the gaming workspace and launchers
-- land there. DP-3 is the LG on the left, DP-1 the Dell on the right. If the
-- mouse crosses the wrong edge, swap the two names here and nothing else.
MONITOR1 = "DP-3"
MONITOR2 = "DP-1"
MONITOR3 = ""
PRIMARY_MONITOR = MONITOR1

-- Workspaces per monitor (max 10). 1-3 live on MONITOR1, 4-6 on MONITOR2.
NUM_WPM = 3
