-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Outputs are named in variables.lua. Logical size at scale 1.5 is 2560x1440,
-- so the second monitor starts at x=2560.

hl.monitor({ output = MONITOR1, mode = "3840x2160@60", position = "0x0",    scale = 1.5 })
hl.monitor({ output = MONITOR2, mode = "3840x2160@60", position = "2560x0", scale = 1.5 })

-- Anything else that gets plugged in (TV, test cable) goes to the right.
hl.monitor({ output = "", mode = "preferred", position = "auto-right", scale = "auto" })
