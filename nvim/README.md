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
| `harpoon` (v2) | File bookmarks |
| `lualine.nvim` | Status line |
| `render-markdown.nvim` | Markdown rendering |
| `yazi.nvim` | File explorer |
| `mini.surround` | Surround text objects |
| `mini.pairs` | Auto-close brackets and quotes |
| `which-key.nvim` | Keybinding hints |
| `lazydev.nvim` | Lua LSP for Neovim config |

## Requirements

- Neovim 0.11+
- A [Nerd Font](https://www.nerdfonts.com/) (CaskaydiaCove recommended)
- `git`, `curl`
- `tree-sitter` CLI (for parser compilation)
- `ripgrep` (`rg`) for the grep pickers (`<leader>sg`, `<leader>ss`)
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

## Keeping plugins up to date

Plugins track their latest commit (no version pins, except blink.cmp, which is
held to `1.*` because its unreleased 2.0 branch is breaking). lazy.nvim checks
for updates in the background and shows the pending count in the statusline.

1. When the statusline shows updates, run `:Lazy update`. Commits marked
   breaking (`!`) are highlighted in the log; read those before moving on.
2. Run `:checkhealth` and skim for new warnings, deprecations included.
3. Commit `lazy-lock.json` — it is a record, not a pin, so a bad update can be
   undone with `:Lazy restore` (restores the committed lock) and then fixed.

`:MasonToolsUpdate` updates the LSP servers / formatters / linters the same way.

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
| `<leader>sd` | Diff current buffer with a file |
| `<leader>so` | Autocmds |
| `<leader>sn` | Notification history |
| `<leader>fn` | New file |
| `<leader>fr` | Rename current file |

### Harpoon (File Bookmarks)

Harpoon lets you pin up to 5 files and jump between them instantly with no typing.

| Key | Action |
|---|---|
| `<leader>ha` | Add current file to Harpoon list |
| `<leader>hh` | Open Harpoon quick menu |
| `<C-n>` | Jump to Harpoon file 1 |
| `<C-e>` | Jump to Harpoon file 2 |
| `<C-i>` | Jump to Harpoon file 3 |
| `<C-o>` | Jump to Harpoon file 4 |
| `<C-'>` | Jump to Harpoon file 5 |

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
| `<leader>gd` | Diff panel: changed files + side-by-side diff (gitsigns) |
| `<leader>gh` | File history (picker) |
| `<leader>gi` | Diff this file against the index (3-way on conflicts) |
| `<leader>gb` | Toggle inline git blame |
| `<leader>gp` | Preview hunk |
| `<leader>gS` | Stage / unstage hunk (toggle) |
| `<leader>gr` | Reset hunk |
| `]c` / `[c` | Next / prev git hunk |
| `<leader>gf` | Git files (picker) |
| `<leader>gB` | Git branches (picker) |
| `<leader>gc` | Repo history (picker) |
| `<leader>gs` | Git status (picker) |

#### Diff panel

`<leader>gd` runs `:Gitsigns diff`: a file tree of changes on the left and a
side-by-side diff on the right.

| Key (in panel) | Action |
|---|---|
| `<CR>` | Open file / toggle directory |
| `]f` / `[f` | Next / prev changed file |
| `]c` / `[c` | Next / prev hunk |
| `s` / `u` / `<Space>` | Stage / unstage / toggle file (or whole directory) |
| `g?` | Show all panel keys |
| `q` | Close |

It also takes revisions: `:Gitsigns diff main...HEAD` (branch review),
`:Gitsigns diff --commit <sha>` (one commit), `:Gitsigns diff HEAD~3 -- lua/`.

**Merge conflicts:** `<leader>gi` on a conflicted file opens a 3-way split —
ours (`:2`) left, the working file centre, theirs (`:3`) right — for reading
the conflict. Resolve in LazyGit (`<leader>gg`, select the file, pick hunks),
or edit the markers in the centre window directly.

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | References (picker) |
| `gri` | Implementations (picker) |
| `grt` | Type definitions (picker) |
| `gO` | Document symbols (picker) |
| `K` | Hover |
| `]d` / `[d` | Next / prev diagnostic |
| `]]` / `[[` | Next / prev reference to word under cursor |
| `<C-s>` (insert) | Signature help |
| `<leader>lg` | Signature help |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lf` | Format file |
| `<leader>ll` | Lint file |
| `<leader>lL` | Lint all open buffers |
| `<leader>ld` | Toggle inline diagnostic (cursor line) |
| `<leader>lD` | Document diagnostics (picker) |
| `<leader>lw` | Workspace diagnostics (picker) |
| `<leader>lS` | Workspace symbols (picker) |
| `<leader>li` | LSP info (checkhealth) |
| `<leader>lI` | Mason installer |
| `<leader>lq` | Send diagnostics to location list |
| `<leader>lx` | Clear diagnostics (they return on next lint / LSP update) |

### Buffers & Sessions

| Key | Action |
|---|---|
| `<leader>c` | Close current buffer |
| `<leader>bo` | Close all other buffers |
| `<leader>Sr` | Restore session (cwd) |
| `<leader>Sl` | Restore last session |
| `<leader>SS` | Select session |
| `<leader>Ss` | Save session |
| `<leader>Sd` | Stop session (don't save on exit) |

### Terminal & Zen

| Key | Action |
|---|---|
| `<C-\>` | Toggle floating terminal |
| `<leader>z` | Toggle zen mode |
| `<leader>d` | Dashboard |

### Tabs

| Key | Action |
|---|---|
| `<leader>Tn` / `<leader>Tc` | New / close tab |
| `<leader>To` | Close other tabs |
| `gt` / `gT` | Next / previous tab (built-in) |
| `<leader>Tf` / `<leader>TL` | First / last tab |
| `<leader>Tmh` / `<leader>Tml` | Move tab left / right |

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
| `sa` + motion + char | Add surrounding (Normal mode) |
| `sa` + char          | Add surrounding (Visual mode) |
| `sd` + char          | Delete surrounding |
| `sr` + old + new     | Replace surrounding |
| `sf` + char          | Find surrounding (move cursor right) |
| `sF` + char          | Find surrounding (move cursor left) |
| `sh` + char          | Highlight surrounding |

**Surrounding identifiers:**

| Char | Meaning |
|---|---|
| `)`, `(` | Parentheses (`(` adds inner padding spaces, `)` does not) |
| `]`, `[` | Square brackets (`[` adds padding, `]` does not) |
| `}`, `{` | Curly braces (`{` adds padding, `}` does not) |
| `>`, `<` | Angle brackets (`<` adds padding, `>` does not) |
| `"`, `'`, `` ` `` | Quotes |
| `f` | Function call (delete finds call, add prompts for name) |
| `t` | HTML/XML tag (prompts for tag name on add) |
| `?` | Interactive (prompts for left and right parts) |

**Examples:**

| Command | Before | After |
|---|---|---|
| `saiw)` | `hello` | `(hello)` |
| `saiw(` | `hello` | `( hello )` |
| `sd)` | `(hello)` | `hello` |
| `sr)"` | `(hello)` | `"hello"` |
| `saiWf` → enter `print` | `hello` | `print(hello)` |
| `sd"` | `"hello"` | `hello` |
| `sr'` `` ` `` | `'hello'` | `` `hello` `` |
| `sa2aw)` | `hello world` | `(hello world)` |

**Note:** `sd` and `sr` take a surrounding **character**, not a motion/text object. For example, use `sd)` to delete parentheses — not `sdiw)`.

### Toggles

| Key | Action |
|---|---|
| `<leader>r` | Toggle relative line numbers |

### Resize

| Key | Action |
|---|---|
| `<A-h>` | Shrink window width |
| `<A-j>` | Grow window height |
| `<A-k>` | Shrink window height |
| `<A-l>` | Grow window width |
