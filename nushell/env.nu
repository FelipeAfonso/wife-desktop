$env.FZF_DEFAULT_OPTS = "--bind ctrl-s:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
$env.ENABLE_INCREMENTAL_TUI = "true"
$env.EDITOR = "nvim"
$env.BROWSER = "zen-browser"
$env.PAGER = "less"
$env.FORCE_COLOR = "1"
$env.LAUNCH_EDITOR = "launch_editor_script"

$env.BUN_INSTALL = $"($env.HOME)/.bun"
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"

$env.PATH = (
    $env.PATH
    | prepend $"($env.HOME)/.local/bin"
    | prepend $env.PNPM_HOME
    | prepend $"($env.BUN_INSTALL)/bin"
    | append $"($env.HOME)/bin"
    | append $"($env.HOME)/.turso"
    | append $"($env.HOME)/go/bin/"
    | append $"($env.HOME)/.fly/bin"
    | uniq
)
