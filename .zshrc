HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify nocaseglob

bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

. ~/.profile

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

alias cl="clear"
alias ls="eza -l"
alias grep="rg"
alias clip="xclip -selection clipboard"

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"

if [[ -n "$INSIDE_EMACS" ]]; then
    set -o emacs
fi
