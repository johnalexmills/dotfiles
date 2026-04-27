# Neovim Configuration

A modern Neovim config built on Neovim 0.11+ features: native LSP config (`vim.lsp.config`), treesitter folding, and `blink.cmp` for completion.

## Plugins

| Plugin | Purpose |
|---|---|
| `lazy.nvim` | Plugin manager |
| `catppuccin` | Colorscheme (Mocha) |
| `nvim-lspconfig` + Mason | LSP servers, formatters, linters |
| `blink.cmp` | Completion |
| `nvim-treesitter` | Syntax highlighting and folding |
| `conform.nvim` | Formatting on save |
| `nvim-lint` | Linting |
| `snacks.nvim` | Picker, dashboard, terminal, indent guides, notifications |
| `gitsigns.nvim` | Git signs and hunk operations |
| `harpoon` (v2) | File bookmarks |
| `bufferline.nvim` | Buffer tabs |
| `lualine.nvim` | Status line |
| `trouble.nvim` | Diagnostics list |
| `render-markdown.nvim` | Markdown rendering |
| `yazi.nvim` | File explorer |
| `mini.surround` | Surround text objects |
| `todo-comments.nvim` | Highlight TODO/FIXME comments |
| `which-key.nvim` | Keybinding hints |
| `lazydev.nvim` | Lua LSP for Neovim config |
| `tiny-inline-diagnostic.nvim` | Inline diagnostics |

## Requirements

- Neovim 0.11+
- A [Nerd Font](https://www.nerdfonts.com/) (CaskaydiaCove recommended)
- `git`, `curl`
- `tree-sitter` CLI (for parser compilation)
- Optional: `lazygit` for the git UI (`<leader>gg`)

## Installation

Run the install script (works on macOS and Linux):

```bash
~/dotfiles/nvim/scripts/install.sh
```

Or set things up manually:

```bash
sudo pacman -S neovim stow tree-sitter   # or: brew install neovim stow tree-sitter
cd ~/dotfiles && stow -t ~ nvim
nvim --headless "+Lazy! sync" +qa
```

## Key Mappings

Leader key is `<Space>`.

| Key | Action |
|---|---|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sb` | Buffers |
| `<leader>gg` | LazyGit |
| `<leader>la` | Code action |
| `<leader>lr` | Rename symbol |
| `<leader>lf` | Format file |
| `<leader>ll` | Lint file |
| `<leader>tt` | Toggle diagnostics (Trouble) |
| `-` | Open yazi (file explorer) |
| `<C-\>` | Toggle floating terminal |
| `<leader>ha` | Harpoon: add file |
| `<leader>hh` | Harpoon: toggle menu |
