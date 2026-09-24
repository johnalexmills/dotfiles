# Herdr Configuration

Herdr is a persistent terminal workspace manager for AI coding agents. This
module installs Herdr and stows its configuration.

## Installation

Run the module installer:

```bash
~/dotfiles/herdr/scripts/install.sh
```

Or run it through the root installer:

```bash
~/dotfiles/install.sh --modules herdr
```

The installer uses Homebrew on macOS and Herdr's official installer on Linux.

## Usage

- `herdr` -- launch or attach to the default session
- `Ctrl+b`, then `?` -- show active keybindings
- `Ctrl+b`, then `q` -- detach while keeping processes running
- `herdr server stop` -- stop the default session

Configuration lives at `~/.config/herdr/config.toml`. Reload changes with
`herdr server reload-config`. The stowed config keeps Herdr's default
keybindings, including the default `Ctrl+b` prefix.
