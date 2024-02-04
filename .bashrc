######################################################################
#
#
#           ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
#           ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
#           ██████╔╝███████║███████╗███████║██████╔╝██║     
#           ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║     
#           ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
#           ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
#
######################################################################

# Use vim navigation in terminal
set -o vi

#########################################
#              Git Aliases              #
#########################################
alias gs='git status -sb'
alias gco='git checkout'
alias gcm='git checkout master'
alias gaa='git add --all'
alias gc='git commit -m $2'
alias push='git push'
alias gpo='git push origin'
alias pull='git pull'
alias clone='git clone'
alias stash='git stash'
alias pop='git stash pop'
alias ga='git add'
alias gb='git branch'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gm='git merge'

#########################################
#              Bash Aliases             #
#########################################
 alias ..='cd ..'
 alias ...='cd ../../'
 alias ....='cd ../../../'
 alias .....='cd ../../../../'
 alias bashclear='echo "" > ~/.bash_history'
 alias c='clear'
 alias ls='ls -F --color=auto --show-control-chars'
 alias ll='ls -l'
 alias ll.='ls -la'
 alias lls='ls -la --sort=size'
 alias llt='ls -la --sort=time'
 alias work='cd /c/Users/554711'
 alias sbrc='source ~/.bashrc && echo "sourced new .bashrc"'
 alias obrc='code ~/.bashrc'
 alias oawsc='code ~/.aws/credentials'
 alias rdevc=''
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
