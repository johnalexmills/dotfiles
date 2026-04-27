# Ghostty Terminal Configuration

Configuration for the Ghostty terminal emulator with Catppuccin Mocha theming and CaskaydiaCove Nerd Font.

## Installation

Run the install script (works on macOS and Linux):

```bash
~/dotfiles/ghostty/scripts/install.sh
```

Or set things up manually:

```bash
# macOS
brew install --cask ghostty
brew install --cask font-caskaydia-cove-nerd-font
brew install stow
cd ~/dotfiles && stow -t ~ ghostty

# Linux (Arch)
sudo pacman -S ghostty ttf-cascadia-code-nerd stow
cd ~/dotfiles && stow -t ~ ghostty
```
