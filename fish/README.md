# Fish Shell Configuration

Fish shell configuration with Catppuccin Mocha theming, starship prompt, zoxide, and fisher plugins.

## Installation

Run the install script (works on macOS and Linux):

```bash
~/dotfiles/fish/scripts/install.sh
```

Or set things up manually:

```bash
sudo pacman -S fish starship zoxide stow   # or: brew install fish starship zoxide stow
cd ~/dotfiles && stow -t ~ fish
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fish -c 'fisher update'
```

Then set fish as your default shell:

```bash
chsh -s $(which fish)
```
