# ~/.config/fish/config.fish
zoxide init fish | source
starship init fish | source

alias rmo='sudo pacman -Rs $(pacman -Qqtd)'
alias ofrc='nvim ~/.config/fish/conf.d/config.fish'
