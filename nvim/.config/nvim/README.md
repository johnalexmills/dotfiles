# Neovim Configuration

A modern Neovim configuration with LSP support, advanced editing features, and beautiful UI enhancements.

## Features

### Core Functionality
- **Lazy.nvim** - Fast plugin manager
- **LSP Support** - Language Server Protocol integration
- **Treesitter** - Advanced syntax highlighting and text objects
- **Telescope** - Fuzzy finder for files, buffers, and more
- **Oil** - File explorer with buffer-like editing

### UI Enhancements
- **Catppuccin** - Beautiful color scheme
- **Lualine** - Statusline
- **Bufferline** - Buffer tabs
- **Alpha** - Dashboard/start screen
- **Noice** - Enhanced UI for messages, cmdline, and popupmenu
- **Which-key** - Key binding hints

### Editing Features
- **Blink-cmp** - Auto-completion
- **Conform** - Code formatting
- **Nvim-lint** - Linting
- **Gitsigns** - Git integration
- **Mini-comment** - Smart commenting
- **Mini-indentscope** - Indent guides
- **Sleuth** - Automatic indentation detection
- **Undotree** - Undo history visualization
- **Todo-comments** - Highlight TODO comments
- **Illuminate** - Highlight word under cursor

### Markdown Support
- **Render-markdown** - Live markdown rendering (auto-enabled)

### Terminal Integration
- **Toggleterm** - Terminal integration
- **Snacks** - Additional utilities

## Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Symlink this configuration:
   ```bash
   ln -sf /path/to/dotfiles/nvim/.config/nvim ~/.config/nvim
   ```

3. Start Neovim - plugins will install automatically via Lazy.nvim

## Key Mappings

The configuration uses space as the leader key. Key mappings are defined in `lua/keymaps.lua` and plugin-specific mappings are in their respective plugin files.

## Plugin Configuration

Individual plugin configurations are located in `lua/plugins/`:

- `alpha.lua` - Dashboard
- `blink-cmp.lua` - Completion
- `bufdelete.lua` - Buffer deletion
- `bufferline.lua` - Buffer tabs
- `colorscheme.lua` - Color scheme
- `conform.lua` - Formatting
- `gitsigns.lua` - Git integration
- `illuminate.lua` - Word highlighting
- `lsp.lua` - Language servers
- `lualine.lua` - Statusline
- `markdown-preview.lua` - Markdown rendering
- `mini-comment.lua` - Commenting
- `mini-indentscope.lua` - Indent guides
- `noice.lua` - UI enhancements
- `nvim-lint.lua` - Linting
- `oil.lua` - File explorer
- `sleuth.lua` - Indent detection
- `snacks.lua` - Utilities
- `telescope.lua` - Fuzzy finder
- `todo-comments.lua` - TODO highlighting
- `toggleterm.lua` - Terminal
- `treesitter.lua` - Syntax highlighting
- `undotree.lua` - Undo history
- `which-key.lua` - Key hints

## Customization

- **Options**: Modify `lua/options.lua`
- **Key mappings**: Edit `lua/keymaps.lua`
- **Autocommands**: Update `lua/autocommands.lua`
- **Plugin settings**: Edit individual files in `lua/plugins/`

## Requirements

- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- Ripgrep (for Telescope live grep)
- Language servers for LSP functionality