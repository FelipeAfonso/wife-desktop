-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font 'Zed Mono'
config.font_size = 18.0
config.default_prog = { '/usr/bin/fish', '-l' }

-- and finally, return the configuration to wezterm
return config
