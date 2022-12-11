source ~/.config/fish/aliases.fish
# source ~/.config/fish/colors.fish

# Configure Jump
status --is-interactive; and source (autojump shell fish | psub)

# Vi Mode
fish_vi_key_bindings

# Suppress greeting message
set fish_greeting ""

# Starship prompt
starship init fish | source

