# Neovim Configuration

Modern Neovim config with LSP, Snacks picker, blink.cmp, Catppuccin.

**Leader key:** `Space`

## Quick Reference

| Action             | Keybinding   |
| ------------------ | ------------ |
| Find files         | `<leader>sf` |
| Live grep          | `<leader>sg` |
| File explorer      | `-`          |
| Toggle terminal    | `Ctrl+\`     |
| Close buffer       | `<leader>c`  |
| LazyGit            | `<leader>gg` |
| Dashboard          | `<leader>d`  |
| Zen mode           | `<leader>z`  |

## Snacks Picker (replaces Telescope)

| Keybinding   | Action                   |
| ------------ | ------------------------ |
| `<leader>sf` | Find files               |
| `<leader>sg` | Live grep                |
| `<leader>ss` | Grep string under cursor |
| `<leader>sb` | Buffers                  |
| `<leader>sh` | Help tags                |
| `<leader>sk` | Keymaps                  |
| `<leader>sc` | Commands                 |
| `<leader>sm` | Man pages                |
| `<leader>sr` | Registers                |
| `<leader>sC` | Colorschemes             |
| `<leader>so` | Options                  |
| `<leader>sn` | Notifications            |

## File Explorer (yazi)

| Keybinding | Action                                     |
| ---------- | ------------------------------------------ |
| `-`        | Open yazi at current file's directory      |
| `<leader>-`| Open yazi at project root                  |

## Terminal

| Keybinding | Action                       |
| ---------- | ---------------------------- |
| `Ctrl+\`   | Toggle floating terminal     |
| `<leader>gg` | Open LazyGit               |

## Buffer Management

| Keybinding   | Action                  |
| ------------ | ----------------------- |
| `Tab`        | Next buffer             |
| `Shift+Tab`  | Previous buffer         |
| `<leader>c`  | Close current buffer    |
| `<leader>bo` | Close all other buffers |

## Window Navigation

| Keybinding | Action               |
| ---------- | -------------------- |
| `Ctrl+h/j/k/l` | Move to window  |
| `Alt+h/j/k/l`  | Resize window   |

## Git Integration

| Keybinding   | Action                   |
| ------------ | ------------------------ |
| `<leader>gg` | Open LazyGit             |
| `<leader>gb` | Toggle git blame         |
| `<leader>gp` | Preview hunk             |
| `<leader>gS` | Stage hunk               |
| `<leader>gr` | Reset hunk               |
| `<leader>gi` | Diff this (inline)       |
| `]c` / `[c`  | Next/prev git hunk       |
| `<leader>gd` | Diffview open            |
| `<leader>gh` | File history             |
| `<leader>gH` | Repo history             |
| `<leader>gf` | Snacks git files         |
| `<leader>gc` | Snacks commits           |
| `<leader>gs` | Snacks git status        |

## LSP

| Keybinding   | Action                      |
| ------------ | --------------------------- |
| `gd`         | Go to definition            |
| `gD`         | Go to declaration           |
| `<leader>lr` | Rename symbol               |
| `<leader>la` | Code actions                |
| `<leader>lg` | Signature help              |
| `<leader>lh` | Toggle inlay hints          |
| `<leader>lR` | References                  |
| `<leader>lt` | Type definitions            |
| `<leader>lm` | Implementations             |
| `<leader>ls` | Document symbols            |
| `<leader>lS` | Workspace symbols           |
| `<leader>lD` | Document diagnostics        |
| `<leader>lw` | Workspace diagnostics       |
| `<leader>lj/k` | Next/prev diagnostic      |
| `<leader>ld` | Toggle inline diagnostics   |
| `<leader>lf` | Format document             |
| `<leader>ll` | Trigger linting             |
| `<leader>lL` | Lint all open buffers       |
| `<leader>li` | LSP info                    |
| `<leader>lI` | Open Mason installer        |

## Trouble (Diagnostics Panel)

| Keybinding   | Action                            |
| ------------ | --------------------------------- |
| `<leader>tt` | Toggle workspace diagnostics      |
| `<leader>tT` | Toggle buffer diagnostics         |
| `<leader>ts` | Toggle symbols                    |
| `<leader>tl` | Toggle LSP definitions/references |
| `<leader>tL` | Toggle location list              |
| `<leader>tQ` | Toggle quickfix list              |

## Todo Comments

| Keybinding | Action               |
| ---------- | -------------------- |
| `]t` / `[t`| Next/prev todo       |
| `<leader>tT` | Search todos (Trouble) |

## Editing

| Keybinding  | Action                                       |
| ----------- | -------------------------------------------- |
| `gcc`       | Toggle comment on line (native)              |
| `gc`        | Toggle comment on selection (native)         |
| `<leader>u` | Undo history (Snacks)                        |
| `<leader>fr`| Rename file (Snacks)                         |
| `<leader>p` | Paste without overwriting clipboard (visual) |
| `<leader>D` | Delete to black hole register                |
| `J/K`       | Move selection up/down (visual)              |
| `<`/`>`     | Indent/unindent and stay in visual mode      |

## Surround (mini.surround)

| Keybinding         | Action                 |
| ------------------ | ---------------------- |
| `sa` + motion + c  | Add surrounding        |
| `sd` + c           | Delete surrounding     |
| `sr` + old + new   | Replace surrounding    |
| `sf` + c           | Find (move right)      |
| `sF` + c           | Find (move left)       |

## Navigation

| Keybinding | Action                        |
| ---------- | ----------------------------- |
| `Ctrl+d/u` | Page down/up (cursor centered)|
| `n/N`      | Next/prev search (centered)   |
| `<leader>/`| Toggle search highlight       |
| `<leader>r`| Toggle relative line numbers  |

## Session Management

| Keybinding   | Action                      |
| ------------ | --------------------------- |
| `<leader>qs` | Restore session             |
| `<leader>qS` | Select session              |
| `<leader>ql` | Restore last session        |
| `<leader>qd` | Don't save current session  |

## Which-Key Groups

Press `<leader>` and wait:

- `b` — Buffer operations
- `c` — Close buffer
- `d` — Dashboard
- `g` — Git operations
- `l` — LSP operations
- `q` — Session (persistence)
- `s` — Snacks picker (search)
- `t` — Trouble
- `T` — Todo

## Features

- **lazy.nvim** — fast lazy-loaded plugin management
- **blink.cmp** — completion (LSP, snippets, path, buffer)
- **Snacks.nvim** — picker, dashboard, terminal, notifications, indent, undo, zen, rename
- **nvim-lint** — linting (luacheck, shellcheck, yamllint, jsonlint, markdownlint, tflint, hadolint, sqlfluff)
- **conform.nvim** — format-on-save (stylua, ruff, prettier, taplo)
- **yazi.nvim** — file explorer
- **harpoon** — quick file navigation
- **Catppuccin Mocha** — colorscheme
- **Lualine** — statusline
- **Bufferline** — buffer tabs
- **Which-key** — keybinding hints
- **Treesitter** — syntax highlighting
- **Gitsigns** — git signs, blame, hunk ops
- **Trouble** — enhanced diagnostics panel
- **Todo-comments** — TODO/FIXME highlighting
- **mini.surround/mini.pairs** — surround + auto-pairs
- **render-markdown** — live markdown preview
- **persistence.nvim** — session management

## Requirements

- Neovim >= 0.11.0
- Nerd Font
- ripgrep (for live grep)
- fd (optional, faster file finding)

## Customization

| What            | File                      |
| --------------- | ------------------------- |
| Editor options  | `lua/options.lua`         |
| Key mappings    | `lua/keymaps.lua`         |
| Auto commands   | `lua/autocommands.lua`    |
| Plugin settings | `lua/plugins/*.lua`       |
