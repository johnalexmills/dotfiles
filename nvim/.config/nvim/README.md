# Neovim Configuration

A modern Neovim configuration with LSP support, advanced editing features, and beautiful UI enhancements.

## Quick Reference

**Leader key:** `Space`

| Action | Keybinding |
|--------|------------|
| Open file explorer | `-` |
| Toggle terminal | `Ctrl+\` |
| Find files | `<leader>tf` |
| Live grep | `<leader>tg` |
| Close buffer | `<leader>x` |
| LazyGit | `<leader>gg` |

## Usage Guide

### Terminal

The terminal uses a floating window for quick access.

| Keybinding | Action |
|------------|--------|
| `Ctrl+\` | Toggle floating terminal (works in any mode) |
| `<leader>gg` | Open LazyGit for git operations |
| `<leader>Tt` | Show project file tree |
| `<leader>Ta` | Show tree including hidden files |
| `<leader>Td` | Show directories only |

**In terminal mode:**
- `Ctrl+\` to close the terminal
- Use normal terminal commands

### File Explorer (Oil)

Oil provides a buffer-like file explorer where you can edit the filesystem like text.

| Keybinding | Action |
|------------|--------|
| `-` | Open file explorer in current directory |
| `Enter` | Open file/directory |
| `-` | Go up to parent directory |

**In Oil buffer:**
- Delete lines to delete files
- Rename by editing the filename
- Create new files by typing new lines
- Save (`:w`) to apply changes

### Finding Files (Telescope)

Telescope is the fuzzy finder for searching everything.

| Keybinding | Action |
|------------|--------|
| `<leader>tf` | Find files |
| `<leader>tg` | Live grep (search file contents) |
| `<leader>ts` | Grep string under cursor |
| `<leader>tb` | Switch buffers |
| `<leader>th` | Search help tags |
| `<leader>tK` | Search keymaps |
| `<leader>tc` | Search commands |
| `<leader>tm` | Search man pages |
| `<leader>tr` | Search registers |
| `<leader>tC` | Browse colorschemes |
| `<leader>to` | Search vim options |

**In Telescope:**
- `Ctrl+j/k` or arrows to navigate
- `Enter` to select
- `Esc` to close
- Type to filter results

### Buffer Management

Buffers are shown as tabs at the top of the screen.

| Keybinding | Action |
|------------|--------|
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `<leader>x` | Close current buffer |
| `<leader>bo` | Close all other buffers |

### Window Navigation

Move between split windows easily.

| Keybinding | Action |
|------------|--------|
| `Ctrl+h` | Move to left window |
| `Ctrl+j` | Move to window below |
| `Ctrl+k` | Move to window above |
| `Ctrl+l` | Move to right window |
| `Alt+h` | Resize window left |
| `Alt+j` | Resize window down |
| `Alt+k` | Resize window up |
| `Alt+l` | Resize window right |

### Git Integration

| Keybinding | Action |
|------------|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>gb` | Toggle git blame on line |
| `<leader>gf` | Find git files |
| `<leader>gB` | Browse branches |
| `<leader>gc` | Browse commits |
| `<leader>gC` | Browse buffer commits |
| `<leader>gs` | Git status |

### LSP (Code Intelligence)

LSP provides code completion, go-to-definition, and diagnostics.

| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover (show docs/type info) |
| `Ctrl+k` | Signature help |
| `<leader>la` | Code actions |
| `<leader>lr` | Rename symbol |
| `<leader>lf` | Format document |
| `<leader>ld` | Toggle inline diagnostics |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lj` | Next diagnostic |
| `<leader>lk` | Previous diagnostic |
| `<leader>lD` | Document diagnostics |
| `<leader>lw` | Workspace diagnostics |
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `<leader>lR` | References (Telescope) |
| `<leader>lt` | Type definitions |
| `<leader>lm` | Implementations |
| `<leader>lL` | CodeLens action |
| `<leader>ll` | Trigger linting |
| `<leader>li` | LSP info |
| `<leader>lI` | Open Mason installer |

### Editing

| Keybinding | Action |
|------------|--------|
| `gcc` | Toggle comment on line |
| `gc` | Toggle comment on selection (visual) |
| `<leader>u` | Toggle undo tree |
| `<leader>p` | Paste without overwriting clipboard (visual) |
| `<leader>D` | Delete to black hole register |
| `J/K` | Move selection up/down (visual) |
| `<`/`>` | Indent/unindent and stay in visual mode |

**Surround (mini.surround):**
- `sa` + motion + char - Add surround (e.g., `saiw"` surrounds word with quotes)
- `sd` + char - Delete surround
- `sr` + old + new - Replace surround

### Navigation

| Keybinding | Action |
|------------|--------|
| `Ctrl+d` | Page down (cursor centered) |
| `Ctrl+u` | Page up (cursor centered) |
| `n` | Next search result (centered) |
| `N` | Previous search result (centered) |

### Utility

| Keybinding | Action |
|------------|--------|
| `<leader>/` | Toggle search highlight |
| `<leader>r` | Toggle relative line numbers |
| `<leader>so` | Source (reload) config |

### Which-Key

Press `<leader>` and wait to see available keybindings organized by category:
- `b` - Buffer operations
- `g` - Git operations
- `l` - LSP operations
- `t` - Telescope (search)
- `T` - Terminal

## Features

### Core
- **Lazy.nvim** - Fast plugin manager with lazy loading
- **LSP Support** - Language Server Protocol (Python, Lua, Bash, Terraform, GDScript)
- **Treesitter** - Advanced syntax highlighting and text objects
- **Telescope** - Fuzzy finder for files, buffers, and more
- **Oil** - File explorer with buffer-like editing

### UI
- **Catppuccin Mocha** - Color scheme
- **Lualine** - Statusline with LSP status and diagnostics
- **Bufferline** - Buffer tabs
- **Alpha** - Dashboard on startup
- **Which-key** - Key binding hints

### Editing
- **Blink-cmp** - Auto-completion (LSP, snippets, buffer, path)
- **Conform** - Code formatting (stylua, black, prettier, etc.)
- **Nvim-lint** - Linting (ruff, shellcheck, yamllint, etc.)
- **Gitsigns** - Git signs and blame
- **Mini.comment** - Commenting with `gcc`
- **Mini.surround** - Surround text manipulation
- **Mini.pairs** - Auto-pairing brackets
- **Undotree** - Undo history visualization

### Terminal
- **Snacks.nvim** - Floating terminal and utilities

### Markdown
- **Render-markdown** - Live markdown rendering

## Installation

1. Backup existing config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Symlink this configuration:
   ```bash
   ln -sf /path/to/dotfiles/nvim/.config/nvim ~/.config/nvim
   ```

3. Start Neovim - plugins install automatically

## Requirements

- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- ripgrep (for live grep)
- fd (optional, for faster file finding)

## Customization

| What | File |
|------|------|
| Editor options | `lua/options.lua` |
| Key mappings | `lua/keymaps.lua` |
| Auto commands | `lua/autocommands.lua` |
| Plugin settings | `lua/plugins/*.lua` |

## Supported Languages

**LSP Servers:**
- Python (pyright)
- Lua (lua_ls)
- Bash (bashls)
- Terraform (terraformls)
- GDScript (gdscript)

**Formatters:**
- Lua: stylua
- Python: black, isort, ruff
- JSON/YAML/Markdown: prettier
- TOML: taplo
- Terraform: terraform_fmt

**Linters:**
- Python: ruff, mypy
- Bash: shellcheck
- YAML: yamllint
- JSON: jsonlint
- Markdown: markdownlint
- Terraform: tflint
- Dockerfile: hadolint
