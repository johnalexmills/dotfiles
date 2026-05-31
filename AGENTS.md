# dotfiles — agent guide

## Repo structure

GNU stow-based dotfiles. Each top-level directory is a stow package mapping
into `$HOME`. 9 modules: `ghostty fish starship nvim tmux yazi aerospace hyprland opencode`.

```
install.sh              — orchestrated setup (installs stow, runs modules in order)
scripts/helpers.sh      — shared bash helpers (detect_os, stow_module, pkg_install, etc.)
<module>/               — stow package root
<module>/scripts/install.sh  — per-module idempotent install script
<module>/.stow-local-ignore — stow ignores: .git, README, scripts, LICENSE
```

## Install

```bash
./install.sh                          # full setup
./install.sh --modules nvim,fish      # selective
./install.sh --adopt                  # pull existing configs into repo (WARNING: overwrites repo files)
./install.sh --replace                # delete existing configs, replace with repo (refuses if uncommitted changes)
./install.sh --dry-run                # preview
```

Or run individual modules: `fish/scripts/install.sh`

## Pre-commit hooks (`.githooks/pre-commit`)

Activated by `install.sh` via `git config core.hooksPath .githooks`. Auto-fixes:
- Trailing whitespace removal
- Ensure trailing newline
- `stylua` on staged `.lua` files (config: `nvim/.config/nvim/.stylua.toml`)
- `shfmt -w -i 2 -ci` on `.sh` files
- `fish_indent -w` on `.fish` files

Aborts commit on: merge conflict markers, private key material.

## CI (`.github/workflows/lint.yml`)

On push/PR to main:
- `shellcheck --severity=warning` on all `.sh`
- `stylua --check nvim/.config/nvim` (check only, no auto-fix)

## Editorconfig (`.editorconfig`)

Spaces, LF, UTF-8. Lua/toml/yaml/fish: indent 2. Makefile: tabs. Markdown: trailing spaces preserved.

## Module details

| Module | Key deps | Post-install |
|--------|----------|-------------|
| nvim | Neovim 0.11+, lazy.nvim, Mason | `nvim --headless "+Lazy! sync" +qa` then `+TSUpdate` |
| fish | fish, fisher, zoxide | `fisher update` reads `fish_plugins` |
| tmux | tmux, TPM | `prefix + I` inside tmux to install plugins |
| hyprland | Linux only. Arch: hyprland, waybar, wofi, SDDM, AUR (catppuccin themes) | Enables SDDM, disables GDM, enables bluetooth |
| aerospace | macOS only | — |
| opencode | opencode CLI | Stows `opencode.jsonc` + skills. Caveman skill tracks upstream SHA |

## Quirks & gotchas

- **`stow_module` always uses `--no-folding`** — stow creates symlinks per-file, not directory symlinks.
- **`--replace` safety** — refuses to run if the module has uncommitted git changes.
- **`detect_os`** returns `linux` or `mac`. Package managers: pacman > apt > dnf > zypper.
- **Nerd font**: CaskaydiaCove Nerd Font required by ghostty, nvim, waybar, etc. Installed per-module.
- **hyprland install** is heavy (~40 packages), assumes Arch + AUR helper (paru/yay).
- **Opencode config** lives in `opencode/.config/opencode/opencode.jsonc`. Restart opencode sessions to pick up changes.
- **No test framework, no build step, no formatter** beyond pre-commit hooks.
- **AGENTS.md is the canonical agent instructions file** — update this when adding/removing modules or changing install flow.
