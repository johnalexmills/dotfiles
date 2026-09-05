# Neovim Configuration

Modern Neovim config with LSP, Snacks picker, blink.cmp, Catppuccin.

**Leader key:** `Space`

## Quick Reference

| Action          | Keybinding   |
| --------------- | ------------ |
| Find files      | `<leader>sf` |
| Live grep       | `<leader>sg` |
| File explorer   | `-`          |
| Toggle terminal | `Ctrl+\`     |
| Close buffer    | `<leader>c`  |
| LazyGit         | `<leader>gg` |
| Dashboard       | `<leader>d`  |
| Zen mode        | `<leader>z`  |

## Snacks Picker (replaces Telescope)

| Keybinding   | Action                                   |
| ------------ | ---------------------------------------- |
| `<leader>sf` | Find files                               |
| `<leader>sg` | Live grep                                |
| `<leader>ss` | Grep word under cursor (normal + visual) |
| `<leader>sb` | Buffers                                  |
| `<leader>sh` | Help tags                                |
| `<leader>sK` | Keymaps                                  |
| `<leader>sc` | Commands                                 |
| `<leader>sm` | Man pages                                |
| `<leader>sr` | Registers                                |
| `<leader>sC` | Colorschemes                             |
| `<leader>so` | Autocmds                                 |
| `<leader>sn` | Notification history                     |
| `<leader>sT` | Todo comments                            |
| `<leader>sd` | Diff current buffer with a file          |
| `<leader>u`  | Undo history                             |

## File Explorer (yazi)

| Keybinding  | Action                                |
| ----------- | ------------------------------------- |
| `-`         | Open yazi at current file's directory |
| `<leader>-` | Open yazi at cwd                      |

## Terminal

| Keybinding   | Action                   |
| ------------ | ------------------------ |
| `Ctrl+\`     | Toggle floating terminal |
| `<leader>gg` | Open LazyGit             |

## Buffer Management

| Keybinding   | Action                  |
| ------------ | ----------------------- |
| `Tab`        | Next buffer             |
| `Shift+Tab`  | Previous buffer         |
| `<leader>c`  | Close current buffer    |
| `<leader>bo` | Close all other buffers |
| `<leader>fn` | New file                |
| `<leader>fr` | Rename file             |

## Window Navigation

| Keybinding     | Action         |
| -------------- | -------------- |
| `Ctrl+h/j/k/l` | Move to window |
| `Alt+h/j/k/l`  | Resize window  |

## Harpoon

| Keybinding   | Action            |
| ------------ | ----------------- |
| `<leader>ha` | Add current file  |
| `<leader>hh` | Toggle quick menu |
| `Ctrl+n`     | Jump to file 1    |
| `Ctrl+e`     | Jump to file 2    |
| `Ctrl+i`     | Jump to file 3    |
| `Ctrl+o`     | Jump to file 4    |
| `Ctrl+'`     | Jump to file 5    |

> `Ctrl+o` and `Ctrl+i` are normally the jumplist back/forward keys, and
> `Ctrl+i` is indistinguishable from `Tab` on terminals without the kitty
> keyboard protocol. Harpoon intentionally takes them here; see the note in
> `lua/plugins/harpoon.lua`.

## Git Integration

| Keybinding   | Action                          |
| ------------ | ------------------------------- |
| `<leader>gg` | Open LazyGit                    |
| `<leader>gb` | Toggle git blame line           |
| `<leader>gp` | Preview hunk                    |
| `<leader>gS` | Stage / unstage hunk (toggle)   |
| `<leader>gr` | Reset hunk                      |
| `<leader>gi` | Diff this (inline)              |
| `]c` / `[c`  | Next/prev git hunk (diff-aware) |
| `<leader>gd` | Diffview open (working tree)    |
| `<leader>gh` | File history                    |
| `<leader>gH` | Repo history                    |
| `<leader>gx` | Close diff view                 |
| `<leader>gf` | Git files                       |
| `<leader>gB` | Git branches                    |
| `<leader>gc` | Git commits                     |
| `<leader>gC` | Buffer commits                  |
| `<leader>gs` | Git status                      |

## LSP

| Keybinding     | Action                                         |
| -------------- | ---------------------------------------------- |
| `gd`           | Go to definition (picker)                      |
| `gD`           | Go to declaration                              |
| `<leader>lr`   | Rename symbol                                  |
| `<leader>la`   | Code actions                                   |
| `<leader>lg`   | Signature help                                 |
| `<leader>lh`   | Toggle inlay hints (servers that support them) |
| `<leader>lR`   | References                                     |
| `<leader>lt`   | Type definitions                               |
| `<leader>lm`   | Implementations                                |
| `<leader>ls`   | Document symbols                               |
| `<leader>lS`   | Workspace symbols                              |
| `<leader>lD`   | Document diagnostics                           |
| `<leader>lw`   | Workspace diagnostics                          |
| `<leader>lj/k` | Next/prev diagnostic                           |
| `<leader>lq`   | Diagnostics to loclist                         |
| `<leader>lx`   | Clear diagnostics                              |
| `<leader>ld`   | Toggle inline diagnostics                      |
| `<leader>lf`   | Format document                                |
| `<leader>ll`   | Lint current file                              |
| `<leader>lL`   | Lint all open buffers                          |
| `<leader>li`   | LSP health check                               |
| `<leader>lI`   | Open Mason installer                           |

Neovim's built-in LSP mappings (`grn`, `gra`, `grr`, `gri`, `gO`, `Ctrl+s`)
also remain available.

## Trouble (Diagnostics Panel)

| Keybinding   | Action                            |
| ------------ | --------------------------------- |
| `<leader>tt` | Toggle workspace diagnostics      |
| `<leader>tT` | Toggle buffer diagnostics         |
| `<leader>ts` | Toggle symbols                    |
| `<leader>tl` | Toggle LSP definitions/references |
| `<leader>tL` | Toggle location list              |
| `<leader>tQ` | Toggle quickfix list              |

## Testing (Neotest)

| Keybinding   | Action                    |
| ------------ | ------------------------- |
| `<leader>nt` | Run nearest test          |
| `<leader>nf` | Run file tests            |
| `<leader>ns` | Run test suite            |
| `<leader>nl` | Run last test             |
| `<leader>no` | Show test output          |
| `<leader>nO` | Toggle output panel       |
| `<leader>np` | Toggle test summary panel |
| `<leader>nq` | Stop running tests        |
| `]n` / `[n`  | Next/prev failed test     |

## Tabs

| Keybinding    | Action           |
| ------------- | ---------------- |
| `<leader>Tn`  | New tab          |
| `<leader>Tc`  | Close tab        |
| `<leader>To`  | Close other tabs |
| `<leader>Th`  | Previous tab     |
| `<leader>Tl`  | Next tab         |
| `<leader>Tf`  | First tab        |
| `<leader>TL`  | Last tab         |
| `<leader>Tmh` | Move tab left    |
| `<leader>Tml` | Move tab right   |

## Todo Comments

| Keybinding   | Action         |
| ------------ | -------------- |
| `]t` / `[t`  | Next/prev todo |
| `<leader>sT` | Search todos   |

## Editing

| Keybinding  | Action                                       |
| ----------- | -------------------------------------------- |
| `gcc`       | Toggle comment on line (native)              |
| `gc`        | Toggle comment on selection (native)         |
| `p`         | Paste without overwriting clipboard (visual) |
| `<leader>D` | Delete to black hole register                |
| `J` / `K`   | Move selection down/up (visual)              |
| `<` / `>`   | Indent/unindent and stay in visual mode      |

## Surround (mini.surround)

| Keybinding        | Action              |
| ----------------- | ------------------- |
| `sa` + motion + c | Add surrounding     |
| `sd` + c          | Delete surrounding  |
| `sr` + old + new  | Replace surrounding |
| `sf` + c          | Find (move right)   |
| `sF` + c          | Find (move left)    |

## Navigation

| Keybinding  | Action                         |
| ----------- | ------------------------------ |
| `Ctrl+d/u`  | Page down/up (cursor centered) |
| `n/N`       | Next/prev search (centered)    |
| `Esc`       | Clear search highlight         |
| `<leader>/` | Toggle search highlight        |
| `<leader>r` | Toggle relative line numbers   |

## Session Management

Backed by persistence.nvim, which also auto-saves on exit.

| Keybinding   | Action                    |
| ------------ | ------------------------- |
| `<leader>Sr` | Restore session for cwd   |
| `<leader>Sl` | Restore last session      |
| `<leader>SS` | Select session            |
| `<leader>Ss` | Save session              |
| `<leader>Sd` | Stop (don't save on exit) |

## Which-Key Groups

Press `<leader>` and wait:

- `b` — Buffer operations
- `f` — File operations
- `g` — Git operations
- `h` — Harpoon
- `l` — LSP operations
- `n` — Neotest
- `s` — Snacks picker (search)
- `S` — Session
- `t` — Trouble
- `T` — Tab

## Features

- **lazy.nvim** — fast lazy-loaded plugin management
- **blink.cmp** — completion (LSP, snippets, path, buffer), pinned to 1.x
- **Snacks.nvim** — picker, dashboard, terminal, notifications, indent, undo, zen, rename
- **nvim-lint** — linting (luacheck, shellcheck, fish, yamllint, jsonlint, markdownlint, tflint, hadolint, sqlfluff, gdlint, rubocop)
- **conform.nvim** — format-on-save (stylua, ruff format + import sort, prettier, taplo, hclfmt, terraform_fmt, gdformat, rubocop)
- **yazi.nvim** — file explorer
- **harpoon** — quick file navigation
- **Catppuccin Mocha** — colorscheme
- **Lualine** — statusline
- **Bufferline** — buffer tabs
- **Which-key** — keybinding hints
- **Treesitter** — highlighting, folds and indent (nvim-treesitter `main` branch)
- **Gitsigns** — git signs, blame, hunk ops
- **Trouble** — enhanced diagnostics panel
- **Todo-comments** — TODO/FIXME highlighting
- **mini.surround/mini.pairs** — surround + auto-pairs
- **render-markdown** — live markdown preview
- **persistence.nvim** — session management

## Language Servers

Installed via Mason, enabled explicitly in `lua/plugins/lsp.lua`:
`ty` and `ruff` (Python), `lua_ls`, `bashls`, `terraformls`, `gdscript`, `yamlls`.

`mason-lspconfig` runs with `automatic_enable = false`, so adding a server to
Mason does not enable it by itself — add it to the `vim.lsp.enable` list too.

## Requirements

- Neovim >= 0.11.0
- Nerd Font
- ripgrep (for live grep)
- fd (optional, faster file finding)

## Customization

| What            | File                   |
| --------------- | ---------------------- |
| Editor options  | `lua/options.lua`      |
| Key mappings    | `lua/keymaps.lua`      |
| Auto commands   | `lua/autocommands.lua` |
| Plugin settings | `lua/plugins/*.lua`    |
