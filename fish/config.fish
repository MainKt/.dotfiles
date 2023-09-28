source ~/.config/fish/alias.fish

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

fish_add_path ~/.cargo/bin/

zoxide init fish | source
starship init fish | source
