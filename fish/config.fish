set -g -x FZF_DEFAULT_OPTS --bind ctrl-s:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all
set -g -x EDITOR nvim
set -g -x BROWSER vivaldi
set -g -x PAGER less
set -g -x FORCE_COLOR 1
set -g -x NVM_DIR ~/.nvm

status --is-interactive
#source ~/.config/fish/config.fish

alias vim="nvim"
alias ls="eza -l"
alias tmw="tmux splitw -h -l 100 && note"
alias svim="sudo -E -s nvim"
alias note="cd ~/od/Apps/remotely-save/Felipe/ && nvim ./Inbox.md"

function np
    npm run $argv
end
function tur
    turbo run dev --filter=$argv
end
function turp
    turbo run dev:prod --filter=$argv
end
function tms
    tmux new -s $argv "tmux splitw -h -l 100 && note"
end
function create
    if test "$argv" = -h
        echo hello there
    end
    set nodes (string split "/" $argv)
    function create_dir
        if test -n "$argv"
            mkdir -p $argv
        end
    end
    set -l dir ""
    for node in $nodes
        set is_file (string match "*.*" $node)
        if test -n "$is_file"
            create_dir $dir
            touch $dir$node
            return 1
        else
            set dir (string join '' $dir $node '/')
        end
    end
    create_dir $dir
end

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
end

nvm use node

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# set --export DOCKER_HOST unix://$XDG_RUNTIME_DIR/docker.sock
