# Minimal zsh: this box is for a browser and a game, the shell is for the
# agents that debug it over ssh/T3. Nothing here should need explaining.

# --- Environment ---
export EDITOR=vim
export BROWSER=zen-browser
export PAGER=less
export BUN_INSTALL="$HOME/.bun"

# --- PATH ---
typeset -U path
path=(
  "$HOME/.local/bin"
  "$BUN_INSTALL/bin"
  $path
)

# --- History ---
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE


# --- Plugins (pacman: zsh-autosuggestions zsh-syntax-highlighting) ---
for p in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
  [[ -f "/usr/share/zsh/plugins/$p/$p.zsh" ]] && source "/usr/share/zsh/plugins/$p/$p.zsh"
done

# --- Wallust colors (dynamic theming) ---
[[ -f "$ZDOTDIR/zsh-colors.sh" ]] && source "$ZDOTDIR/zsh-colors.sh"

# --- Prompt ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%f'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f${vcs_info_msg_0_} %F{green}❯%f '
