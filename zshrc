# Source Prezto if available
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

export VISUAL='vim'
export EDITOR="$VISUAL"
# export VIMCONFIG=~/.config/nvim
# export VIMDATA=~/.local/share/nvim

# enable Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# wsl
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# we using asdf?
[[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]] && source /opt/homebrew/opt/asdf/libexec/asdf.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
