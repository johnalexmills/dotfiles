# Tmux Configuration

A tmux configuration with Catppuccin Mocha theming, vim-style keybindings, and sensible defaults.

**Prefix key:** `Ctrl+a`

## Sessions

Sessions let you organize separate projects. Open a new fish shell to use these aliases:

- `tn name` -- new session
- `ta name` -- attach to session
- `tl` -- list sessions
- `tk name` -- kill a session

Inside tmux, press `prefix + d` to detach and `prefix + s` to switch sessions.

## Windows

Windows are tabs within a session.

- `prefix + c` -- new window
- `prefix + n` / `prefix + p` -- next / previous window
- `prefix + 1-9` -- jump to window by number

## Panes

Panes split a window into multiple terminals.

- `prefix + pipe` -- split vertically (side by side)
- `prefix + -` -- split horizontally (top and bottom)
- `prefix + h/j/k/l` -- navigate between panes
- `prefix + H/J/K/L` -- resize panes
- `prefix + z` -- zoom pane to full screen (toggle)
- `prefix + x` -- close current pane

## Copy Mode

- `prefix + [` -- enter copy mode
- `v` -- begin selection
- `y` -- yank selection
- `q` -- exit copy mode

## Installation

Run the install script (works on macOS and Linux):

```bash
~/dotfiles/tmux/scripts/install.sh
```

Or set things up manually:

```bash
sudo pacman -S tmux stow                # or: brew install tmux stow
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd ~/dotfiles && stow tmux
```

Then start tmux and press `prefix + I` to install plugins.
