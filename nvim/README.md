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
| `snacks.nvim` | Picker, dashboard, terminal, indent guides, notifications, undo history |
| `gitsigns.nvim` | Git signs and hunk operations |
| `diffview.nvim` | Side-by-side diffs and merge conflict resolution |
| `harpoon` (v2) | File bookmarks |
| `neotest` + `neotest-python` | Test runner |
| `bufferline.nvim` | Buffer tabs |
| `lualine.nvim` | Status line |
| `trouble.nvim` | Diagnostics list |
| `render-markdown.nvim` | Markdown rendering |
| `yazi.nvim` | File explorer |
| `mini.surround` | Surround text objects |
| `mini.pairs` | Auto-close brackets and quotes |
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
- Optional: `yazi` for the file explorer (`-`)

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

---

## Key Mappings

Leader key is `<Space>`.

### Navigation

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between splits |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<C-d>` / `<C-u>` | Scroll down / up (cursor stays centered) |
| `n` / `N` | Next / prev search result (centered) |
| `<Esc>` | Clear search highlight |
| `-` | Open yazi at current file |
| `<leader>-` | Open yazi at project root |

### File & Search (Snacks Picker)

| Key | Action |
|---|---|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>ss` | Grep word under cursor |
| `<leader>sb` | Open buffers |
| `<leader>sh` | Help tags |
| `<leader>sK` | Keymaps |
| `<leader>sc` | Commands |
| `<leader>sm` | Man pages |
| `<leader>sr` | Registers |
| `<leader>sC` | Colorschemes |
| `<leader>sT` | TODO comments |
| `<leader>fn` | New file |
| `<leader>fr` | Rename current file |

### Harpoon (File Bookmarks)

Harpoon lets you pin up to 5 files and jump between them instantly with no typing.

| Key | Action |
|---|---|
| `<leader>ha` | Add current file to Harpoon list |
| `<leader>hh` | Open Harpoon quick menu |
| `<M-n>` | Jump to Harpoon file 1 |
| `<M-e>` | Jump to Harpoon file 2 |
| `<M-i>` | Jump to Harpoon file 3 |
| `<M-o>` | Jump to Harpoon file 4 |
| `<M-'>` | Jump to Harpoon file 5 |

**Workflow:** Open the quick menu (`<leader>hh`) to see and reorder your pinned files. Edit the list like a normal buffer — delete lines to remove pins, reorder with `dd`/`p`.

### Undo History (Snacks Picker)

| Key | Action |
|---|---|
| `<leader>u` | Open undo history picker |

The undo picker shows a visual, searchable tree of every state your buffer has been in — including branches created by undoing and then making new edits. Select an entry to preview it; press `<CR>` to restore that state.

**Tip:** Unlike linear undo (`u`), the picker lets you recover changes that would normally be lost after you undo and then type something new.

### Git

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |
| `<leader>gd` | Open Diffview (working tree) |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | Full repo history |
| `<leader>gx` | Close Diffview |
| `<leader>gi` | Inline diff this file (gitsigns) |
| `<leader>gb` | Toggle inline git blame |
| `<leader>gp` | Preview hunk |
| `<leader>gS` | Stage hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gr` | Reset hunk |
| `]c` / `[c` | Next / prev git hunk |
| `<leader>gf` | Git files (picker) |
| `<leader>gB` | Git branches (picker) |
| `<leader>gc` | Git commits (picker) |
| `<leader>gC` | Buffer commits (picker) |
| `<leader>gs` | Git status (picker) |

#### Diffview

`<leader>gd` opens a full-screen diff panel with a file tree on the left and a side-by-side diff on the right.

| Key (in Diffview) | Action |
|---|---|
| `<Tab>` / `<S-Tab>` | Next / prev changed file |
| `]c` / `[c` | Next / prev hunk |
| `<leader>e` | Focus / toggle file panel |
| `q` | Close Diffview |

**Merge conflicts:** Run `<leader>gd` during a merge. You'll see a 3-pane layout:
- **Left:** LOCAL (your changes)
- **Center:** BASE (common ancestor)
- **Right:** REMOTE (incoming changes)
- **Bottom:** RESULT (what gets saved — edit this to resolve)

Save the RESULT buffer and close Diffview when done.

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `<leader>lg` | Signature help |
| `<leader>lh` | Toggle inlay hints |
| `<leader>la` | Code action |
| `<leader>lr` | Rename symbol |
| `<leader>lf` | Format file |
| `<leader>ll` | Lint file |
| `<leader>lL` | Lint all open buffers |
| `<leader>lj` / `<leader>lk` | Next / prev diagnostic |
| `<leader>ld` | Toggle inline diagnostics |
| `<leader>lD` | Document diagnostics (picker) |
| `<leader>lw` | Workspace diagnostics (picker) |
| `<leader>ls` | Document symbols (picker) |
| `<leader>lS` | Workspace symbols (picker) |
| `<leader>lR` | References (picker) |
| `<leader>lm` | Implementations (picker) |
| `<leader>lt` | Type definitions (picker) |
| `<leader>lC` | Code lens |
| `<leader>li` | LSP info (checkhealth) |
| `<leader>lI` | Mason installer |
| `<leader>lq` | Send diagnostics to location list |
| `<leader>lx` | Refresh diagnostics |

### Diagnostics & Trouble

| Key | Action |
|---|---|
| `<leader>tt` | All workspace diagnostics |
| `<leader>tT` | Buffer diagnostics |
| `<leader>ts` | Document symbols |
| `<leader>tl` | LSP definitions / references (right panel) |
| `<leader>tL` | Location list |
| `<leader>tQ` | Quickfix list |

### Neotest (Python & more)

| Key | Action |
|---|---|
| `<leader>nt` | Run nearest test |
| `<leader>nf` | Run all tests in file |
| `<leader>ns` | Run entire test suite |
| `<leader>nl` | Re-run last test |
| `<leader>nd` | Debug nearest test (DAP) |
| `<leader>no` | Show test output |
| `<leader>nO` | Toggle output panel |
| `<leader>np` | Toggle summary panel |
| `<leader>nq` | Stop tests |
| `]n` / `[n` | Next / prev failed test |

**Summary panel** (`<leader>np`) shows a file tree of all tests with pass/fail icons. Inside the panel: `<CR>` to jump to a test, `r` to run it, `o` to open its output.

**Virtualenv detection:** Automatically uses `.venv`, `venv`, or `.env` in the project root, then falls back to the system Python.

### Buffers & Sessions

| Key | Action |
|---|---|
| `<leader>c` | Close current buffer |
| `<leader>bo` | Close all other buffers |
| `<leader>Sr` | Restore session |
| `<leader>Ss` | Save session |
| `<leader>Sd` | Stop session (don't save on exit) |

### Terminal & Zen

| Key | Action |
|---|---|
| `<C-\>` | Toggle floating terminal |
| `<leader>z` | Toggle zen mode |

### Editing

| Key | Action |
|---|---|
| `<leader>D` | Delete to black hole (keep clipboard) |
| `p` (visual) | Paste without overwriting clipboard |
| `J` (visual) | Move selected block down |
| `K` (visual) | Move selected block up |
| `<` / `>` (visual) | Indent and stay in visual mode |
| `J` (normal) | Join lines (cursor stays in place) |
| `gc` / `gcc` | Toggle comment (Neovim 0.10+ built-in) |
| `sa` / `sd` / `sr` | mini.surround: add / delete / replace surrounding |
| `<leader>/` | Toggle search highlight |
| `<leader>r` | Toggle relative line numbers |

### Resize

| Key | Action |
|---|---|
| `<A-h>` | Shrink window width |
| `<A-j>` | Grow window height |
| `<A-k>` | Shrink window height |
| `<A-l>` | Grow window width |
