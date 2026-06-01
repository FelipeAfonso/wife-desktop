source themes/tokyonight.nu
source commands/ssh-agent.nu
source commands/create.nu
source commands/codesession.nu
source commands/multicode.nu

# zoxide init: regenerate with `zoxide init nushell | save -f ~/.zoxide.nu`
source ~/.zoxide.nu

$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.color_config = $tokyonight_theme

# Aliases
alias vim = nvim
alias orchid = tmux-orchid
# alias ls = eza -l
alias svim = sudo -E -s nvim

# Commands
def --env note [] {
    cd ~/gdrive/Documents/Obsidian/Felipe
    ^nvim ./Inbox.md
}

def tmw [] {
    ^tmux splitw -h -l 100
    note
}

def np [...args: string] {
    ^npm run ...$args
}

def tur [filter: string] {
    ^turbo run dev $"--filter=($filter)"
}

def turp [filter: string] {
    ^turbo run dev:prod $"--filter=($filter)"
}

def tms [name: string] {
    ^tmux new -s $name "tmux splitw -h -l 100 && note"
}

# Prompt
$env.PROMPT_COMMAND = {||
    let path = (
        if ($env.PWD | str starts-with $env.HOME) {
            $"~($env.PWD | str replace $env.HOME '')"
        } else {
            $env.PWD
        }
    )

    let git_branch = (do { ^git branch --show-current } | complete)
    let git_info = if $git_branch.exit_code == 0 {
        let branch = ($git_branch.stdout | str trim)
        let status = (do { ^git status --porcelain } | complete)
        let indicator = if ($status.stdout | str trim | is-empty) {
            $"(ansi green)✓(ansi reset)"
        } else {
            $"(ansi blue)*(ansi reset)"
        }
        $"|(ansi green)($branch)(ansi reset)($indicator)"
    } else {
        ""
    }

    $"(ansi cyan)($path)(ansi reset)($git_info)\n"
}

$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = {|| "➤ " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "➤ " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| ">> " }

# SSH agent
start-ssh-agent

# FZF keybindings
$env.config.keybindings = (
    $env.config.keybindings | append [
        {
            name: fzf_history
            modifier: control
            keycode: char_r
            mode: [emacs vi_insert vi_normal]
            event: {
                send: executehostcommand
                cmd: "commandline edit --replace (
                    history | get command | reverse | uniq | str join (char nl) | ^fzf --scheme=history | str trim
                )"
            }
        }
        {
            name: fzf_file
            modifier: control
            keycode: char_t
            mode: [emacs vi_insert]
            event: {
                send: executehostcommand
                cmd: "commandline edit --insert (^fzf | str trim)"
            }
        }
        {
            name: fzf_cd
            modifier: alt
            keycode: char_c
            mode: [emacs vi_insert vi_normal]
            event: {
                send: executehostcommand
                cmd: "cd (^fd --type d | ^fzf | str trim)"
            }
        }
    ]
)
