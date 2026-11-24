# PATH: personal bins first, then system/Homebrew (set in ~/.zprofile).
export PATH=~/bin:~/.bin:/usr/local/bin:/usr/local/sbin:$PATH
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

# History shared across terminal sessions.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_IGNORE_SPACE

# Directory navigation (from Prezto's directory module): `cd -<TAB>` walks the stack.
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT INTERACTIVE_COMMENTS

# Completion: menu selection, case-insensitive matching, and colors.
autoload -Uz compinit
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors 'di=1;36' 'ln=1;35' 'ex=1;32'

# Vi editing mode (Esc for normal mode), with prefix-aware history arrows.
bindkey -v
KEYTIMEOUT=1  # switch to normal mode without the default 0.4s Esc delay
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# Development runtimes.
(( $+commands[mise] )) && eval "$(mise activate zsh)"

# Fuzzy history (Ctrl-R), file picker (Ctrl-T), directory picker (Alt-C).
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS='--height=45% --layout=reverse --border=rounded --color=border:magenta,pointer:cyan,marker:magenta'
  source <(fzf --zsh)
fi

# Faint inline suggestions from command history.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
ZSH_AUTOSUGGEST_STRATEGY=(history)

# Up accepts a visible suggestion; otherwise it searches matching history.
_accept-suggestion-or-history-up() {
  if [[ -n $POSTDISPLAY ]]; then
    zle autosuggest-accept
  else
    zle up-line-or-beginning-search
  fi
}
zle -N _accept-suggestion-or-history-up
bindkey '^[[A' _accept-suggestion-or-history-up
bindkey '^[OA' _accept-suggestion-or-history-up

# Optional plugins, installed under your home directory.
[[ -r "$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Two-line prompt with Nerd Font icons (built into Ghostty).
(( $+commands[starship] )) && eval "$(starship init zsh)"

# Syntax highlighting must load after other line-editor integrations.
[[ -r "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export VISUAL='vim'
export EDITOR="$VISUAL"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Jump to frequently used directories: z project-name.
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
