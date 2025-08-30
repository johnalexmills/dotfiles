# Nushell Configuration

This directory contains a comprehensive Nushell configuration optimized for development workflows and consistent with your existing dotfiles.

## Features

### 🚀 Performance & UX
- Starship prompt integration (matching your existing setup)
- Zoxide integration for smart directory navigation
- FZF integration with preview support
- Modern command replacements (bat, fd, rg, etc.)
- Custom keybindings for history and completion menus

### 🛠 Development Tools
- Git aliases matching your bash/fish setup
- Docker completions
- SSH host completions
- Package manager completions (Arch Linux)
- Cargo/NPM completions

### 📁 File Structure
```
.config/nushell/
├── config.nu        # Main configuration
├── env.nu          # Environment variables
├── aliases.nu      # Command aliases
├── functions.nu    # Custom functions
└── completions.nu  # Tab completions
```

## Installation with Stow

From your dotfiles directory:
```bash
stow nushell
```

## First Run Setup

After installation, run these commands to set up integrations:

```bash
# Initialize starship (done automatically)
starship init nu | save ~/.cache/starship/init.nu

# Initialize zoxide (if installed)
zoxide init nushell | save ~/.cache/zoxide/init.nu

# Initialize atuin (if installed)
atuin init nu | save ~/.cache/atuin/init.nu
```

## Key Features

### Aliases
- Navigation: `..`, `...`, `....` for directory traversal
- Git: `gs`, `gco`, `gc`, `push`, `pull`, etc. (matching your bash setup)
- Modern tools: `cat` → `bat`, `find` → `fd`, `grep` → `rg`

### Functions
- `ivn` - Interactive file selection with preview (like your bash version)
- `gl` - Pretty git log (matching your bash alias)
- `mkcd` - Create and change to directory
- `extract` - Universal archive extraction
- `weather` - Quick weather lookup
- `serve` - Quick HTTP server
- `backup` - Create timestamped backups

### Completions
- Git branch names for `git checkout`
- Docker container names
- SSH hosts from ~/.ssh/config
- Systemctl services
- Package names for pacman
- Cargo commands and NPM scripts

## Configuration Highlights

- **Editor**: nvim (matching your setup)
- **Prompt**: Starship (your existing config)
- **History**: 100k entries, synced on enter
- **Colors**: Catppuccin-friendly theme
- **Tables**: Rounded borders, smart truncation
- **Performance**: Optimized settings for large codebases

## Integration Notes

- Respects XDG Base Directory specification
- Compatible with your existing Ghostty terminal
- Uses your Starship configuration
- Maintains consistency with bash/fish aliases
- Supports both modern and traditional command-line tools