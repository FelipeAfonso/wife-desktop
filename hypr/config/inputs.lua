-- Input configuration

hl.config({
    input = {
        -- US board, Brazilian Portuguese typist. alt-intl is what worked in the
        -- installer and what /etc/vconsole.conf and localectl carry; keep them
        -- in sync.
        kb_layout  = "us",
        kb_variant = "alt-intl",

        follow_mouse = 1,
        accel_profile = "flat",
        -- sensitivity = -0.25,
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
