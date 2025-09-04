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
alias ll. = ls --long --all
alias lls = ls --long --all | sort-by size
alias llt = ls --long --all | sort-by modified

# Clear screen
alias c = clear

# Git aliases (matching your bash config)
alias gs = ^git status --short --branch
alias gco = ^git checkout
alias gcm = ^git checkout master  # or main
alias gaa = ^git add --all
alias gc = ^git commit --message
alias push = ^git push
alias gpo = ^git push origin
alias pull = ^git pull
alias clone = ^git clone
alias stash = ^git stash
alias pop = ^git stash pop
alias ga = ^git add
alias gb = ^git branch
alias gl = ^git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
alias gm = ^git merge
alias lg = ^lazygit

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
alias oc = ^powershell -Command '$env:NODE_TLS_REJECT_UNAUTHORIZED="0"; opencode'

# Interactive file editing with fzf (converted from bash)
def --env ivn [] {
    let file = (fzf --multi --preview "bat --color=always {}")
    if ($file | is-not-empty) {
        nvim $file
    }
}

# Package management (Arch Linux specific from your fish config)  
def rmo [] {
    sudo pacman -Rs (pacman -Qqtd | lines)
}

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

###################################################
#               Credential Shortcuts              #
###################################################

# Britive Prod Login
alias bprod = ^pybritive checkout "AWS-TMNA/575013707458/secana-admin-prod" -a prod

# Britive Dev login
alias bdev = ^pybritive checkout "AWS-TMNA/575013707458/secana-dev-prod" -a prod

# Britive Dev for Lambdas login (boto3 looks for default profile by default)
alias bdefault = ^pybritive checkout "AWS-TMNA/186292372128/sec_ana-admin-nonprod" -a default

# Britive Dev for Lambdas login (boto3 looks for default profile by default)
alias bnonprod = ^pybritive checkout "AWS-TMNA/186292372128/sec_ana-admin-nonprod" -a nonprod

###################################################
#           Update aws default to dev             #
###################################################

alias uawsdd = ^bash ~/my_scripts/update_aws_default.sh

#########################################
#           Terraform Alias             #
#########################################

alias tf = ^"C:/Users/554711/AppData/Local/Microsoft/WinGet/Links/terraform.exe"

#########################################
#          Terragrunt Alias             #
#########################################

alias tg = ^"C:/Users/554711/AppData/Local/Microsoft/WinGet/Links/terragrunt.exe"

#########################################
#              BFG Alias                #
#########################################
alias bfg = ^"C:/ProgramData/chocolatey/lib/bfg-repo-cleaner/tools/"

