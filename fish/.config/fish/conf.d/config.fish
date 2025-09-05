# ~/.config/fish/config.fish
zoxide init fish | source
starship init fish | source

alias rmo='sudo pacman -Rs $(pacman -Qqtd)'
alias ofrc='nvim ~/.config/fish/conf.d/config.fish'
alias cd='z'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# List variants
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# System shortcuts
alias cls='clear'
alias h='history'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'

# Neovim shortcut
alias v='nvim'

# Pacman shortcuts (since you're on Arch)
alias pac='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias pacs='pacman -Ss'
alias paci='pacman -Si'
