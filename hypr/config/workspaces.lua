-- Workspace rules wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- NUM_WPM workspaces per monitor, numbered straight through: 1-3 on MONITOR1,
-- 4-6 on MONITOR2. Super+<n> jumps to workspace n wherever it lives.

hl.workspace_rule({ workspace = "name:gaming", monitor = PRIMARY_MONITOR, default = true })

for i = 1, NUM_WPM do
    hl.workspace_rule({ workspace = tostring(i), monitor = MONITOR1, default = (i == 1), persistent = true })
end
if MONITOR2 ~= "" then
    for i = NUM_WPM + 1, NUM_WPM * 2 do
        hl.workspace_rule({ workspace = tostring(i), monitor = MONITOR2, default = (i == NUM_WPM + 1), persistent = true })
    end
end
