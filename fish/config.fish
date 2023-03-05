source ~/.config/fish/alias.fish

# Vi Mode
fish_vi_key_bindings

# Suppress greeting message
set fish_greeting ""

# Starship prompt
starship init fish | source

# zoxide
zoxide init fish | source
