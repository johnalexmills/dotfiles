# ~/.config/fish/config.fish
zoxide init fish | source
starship init fish | source

alias rmo='sudo pacman -Rs $(pacman -Qqtd)'
alias ofrc='nvim ~/.config/fish/conf.d/config.fish'
alias sfrc='source ~/.config/fish/conf.d/config.fish'
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

# Tmux shortcuts
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

# Quick venv activation/deactivation
function venv
    if set -q VIRTUAL_ENV
        deactivate
        return
    end

    set -l dir (pwd)
    while test "$dir" != "/"
        # Check exact matches first, then glob for venv-* and .venv-*
        for candidate in $dir/.venv $dir/venv $dir/.venv-* $dir/venv-*
            if test -f "$candidate/bin/activate.fish"
                source "$candidate/bin/activate.fish"
                echo "Activated: $candidate"
                return
            end
        end
        set dir (dirname $dir)
    end
    echo "No venv found"
end

# Pacman shortcuts (since you're on Arch)
alias pac='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias pacs='pacman -Ss'
alias paci='pacman -Si'
alias pacr='sudo pacman -Runs'
