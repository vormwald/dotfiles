# Source Prezto if available
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:~/.bin:$PATH

export VISUAL='vim'
export EDITOR="$VISUAL"

eval "$(gh copilot alias -- zsh)"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# enable Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# wsl
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ASDF
[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]  && . /opt/homebrew/opt/asdf/libexec/asdf.sh
[ -f ~/.asdf/asdf.sh ] && . "$HOME/.asdf/asdf.sh"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# enable zoxide
eval "$(zoxide init zsh)"
