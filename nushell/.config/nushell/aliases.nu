# Nushell Aliases
# Consistent with your bash/fish aliases where possible

# Navigation aliases (consistent with your dotfiles)
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..

# List commands with better defaults
alias ls = ls --long
alias ll = ls --long
alias la = ls --long --all
alias lls = ls --long --all | sort-by size
alias llt = ls --long --all | sort-by modified

# Clear screen
alias c = clear

# Git aliases (matching your bash config)
alias gs = git status --short --branch
alias gco = git checkout
alias gcm = git checkout master  # or main
alias gaa = git add --all
alias gc = git commit --message
alias push = git push
alias gpo = git push origin
alias pull = git pull
alias clone = git clone
alias stash = git stash
alias pop = git stash pop
alias ga = git add
alias gb = git branch
alias gm = git merge
alias lg = lazygit

# Modern replacements for classic commands
if (which bat | is-not-empty) {
    alias cat = bat
}

if (which fd | is-not-empty) {
    alias find = fd
}

if (which rg | is-not-empty) {
    alias grep = rg
}

if (which dust | is-not-empty) {
    alias du = dust
}

if (which btm | is-not-empty) {
    alias top = btm
}

if (which procs | is-not-empty) {
    alias ps = procs
}

# Editor aliases
alias v = nvim
alias vim = nvim

# Package management (Arch Linux specific from your fish config)
alias rmo = sudo pacman -Rs (pacman -Qqtd)

# Quick config editing
alias obrc = nvim ~/.bashrc
alias ofrc = nvim ~/.config/fish/conf.d/config.fish
alias onurc = nvim ~/.config/nushell/config.nu

# Directory shortcuts
alias cdot = cd ~/dotfiles
alias cdev = cd ~/Developer
alias cdown = cd ~/Downloads

# Quick system info
alias sysinfo = sys
alias diskinfo = df --human-readable
