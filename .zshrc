# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=/opt/homebrew/bin:$PATH

# set theme of syntax zsh-syntax-highlighting
source ~/.oh-my-zsh/custom/themes/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

alias lg='lazygit'
alias rmo='sudo pacman -Rs $(pacman -Qqtd)'
alias ivn='nvim $(fzf -m --preview="bat --color=always {}")'
source $ZSH/oh-my-zsh.sh

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# bun completions
[ -s "/home/phantom/.bun/_bun" ] && source "/home/phantom/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Go 
export PATH=$PATH:$HOME/go/bin

# Claude CLI alias - OS dependent
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias claude="/Users/alexmills/.claude/local/claude"
else
    alias claude="/home/phantom/.claude/local/claude"
fi
