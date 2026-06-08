# --- Environment ---
export FZF_DEFAULT_OPTS="--bind ctrl-s:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
export ENABLE_INCREMENTAL_TUI=true
export EDITOR=nvim
export BROWSER=zen-browser
export PAGER=less
export FORCE_COLOR=1
export NVM_DIR=/usr/share/nvm
export LAUNCH_EDITOR=launch_editor_script
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"

# --- PATH ---
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$HOME/.fly/bin"
  "$HOME/.turso"
  "$BUN_INSTALL/bin"
  "$PNPM_HOME"
  "$HOME/bin"
  $path
)

# --- History ---
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# --- Aliases ---
alias vim="nvim"
alias orchid="tmux-orchid"
alias ls="eza -l"
alias tmw="tmux splitw -h -l 100 && note"
alias svim="sudo -E -s nvim"
alias note='cd ~/gdrive/Documents/Obsidian/Felipe && nvim ./Inbox.md'

# --- Small functions ---
np() { npm run "$@" }
tur() { turbo run dev --filter="$1" }
turp() { turbo run dev:prod --filter="$1" }
tms() { tmux new -s "$1" "tmux splitw -h -l 100 && note" }

# --- Autoloaded functions ---
fpath=("$ZDOTDIR/functions" $fpath)
autoload -Uz codesession multicode create

# --- Vi mode ---
bindkey -v
export KEYTIMEOUT=1

zle-keymap-select() {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;
    viins|main) echo -ne '\e[3 q' ;;
  esac
}
zle -N zle-keymap-select

zle-line-init() { echo -ne '\e[3 q' }
zle -N zle-line-init

# --- SSH agent ---
if [[ -z "$SSH_AGENT_PID" ]] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
  eval "$(ssh-agent -s)" >/dev/null
fi

# --- NVM (lazy) ---
if [[ -d "$NVM_DIR" ]]; then
  nvm() {
    unfunction nvm
    source "$NVM_DIR/init-nvm.sh"
    nvm "$@"
  }
  if [[ -f .nvmrc ]]; then
    source "$NVM_DIR/init-nvm.sh"
    nvm use
  fi
fi

# --- Tool integrations ---
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# cd=z after zoxide init so the alias points to the real function
alias cd="z"

# --- Plugins ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# --- Wallust colors (dynamic theming) ---
[[ -f "$ZDOTDIR/zsh-colors.sh" ]] && source "$ZDOTDIR/zsh-colors.sh"

# --- Prompt ---
eval "$(starship init zsh)"
