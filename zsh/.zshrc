# --- Environment ---
export FZF_DEFAULT_OPTS="--bind ctrl-s:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
export ENABLE_INCREMENTAL_TUI=true
export EDITOR=nvim
export BROWSER=zen-browser
export PAGER=less
export FORCE_COLOR=1
export NVM_DIR=/usr/share/nvm
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
alias ls="eza -l"
alias tmw="tmux splitw -h -l 100 && note"
alias svim="sudo -E -s nvim"
alias note='cd ~/gdrive/Documents/Obsidian/Felipe && nvim ./Inbox.md'

# --- Small functions ---
np() { npm run "$@" }
tur() { turbo run dev --filter="$1" }
turp() { turbo run dev:prod --filter="$1" }
tms() { tmux new -s "$1" "tmux splitw -h -l 100 && note" }

# Shadow lazygit so the shell follows repo/worktree switches: on exit,
# lazygit writes its final directory to LAZYGIT_NEW_DIR_FILE and we cd
# there. lazygit won't create the parent dir itself, hence the mkdir.
lazygit() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
  mkdir -p ~/.lazygit
  command lazygit "$@"
  if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
    cd "$(cat "$LAZYGIT_NEW_DIR_FILE")" || return
    rm -f "$LAZYGIT_NEW_DIR_FILE" > /dev/null
  fi
}
alias lg="lazygit"

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
for p in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
  [[ -f "/usr/share/zsh/plugins/$p/$p.zsh" ]] && source "/usr/share/zsh/plugins/$p/$p.zsh"
done

# --- Wallust colors (dynamic theming) ---
[[ -f "$ZDOTDIR/zsh-colors.sh" ]] && source "$ZDOTDIR/zsh-colors.sh"

# --- Secrets (written by secrets-pull from the private secrets repo) ---
if [[ -f "$ZDOTDIR/.secrets.env" ]]; then
  set -a; source "$ZDOTDIR/.secrets.env"; set +a
fi

# --- Prompt ---
eval "$(starship init zsh)"
