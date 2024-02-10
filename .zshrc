# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# set theme of syntax zsh-syntax-highlighting
source ~/.oh-my-zsh/custom/themes/catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

alias lg='lazygit'

source $ZSH/oh-my-zsh.sh

# activate starship prompt
eval "$(starship init zsh)"
