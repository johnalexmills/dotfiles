# dotfiles — agent guide

## Repo structure

GNU stow-based dotfiles. Each top-level directory is a stow package mapping
into `$HOME`. 8 modules: `ghostty fish starship nvim herdr yazi aerospace opencode`.

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

Spaces, LF, UTF-8. Lua/toml/yaml/fish/sh: indent 2. Makefile: tabs. Markdown: trailing spaces preserved.

## Module details

| Module | Key deps | Post-install |
|--------|----------|-------------|
| nvim | Neovim 0.11+, lazy.nvim, Mason | `nvim --headless "+Lazy! sync" +qa` then `+TSUpdate` |
| fish | fish, fisher, zoxide | `fisher update` reads `fish_plugins` |
| herdr | Herdr CLI | Stows `config.toml`; Homebrew on macOS, official installer on Linux |
| aerospace | macOS only | — |
| opencode | opencode CLI | Stows `opencode.jsonc` and `instructions/` |

## Quirks & gotchas

- **`stow_module` always uses `--no-folding`** — stow creates symlinks per-file, not directory symlinks.
- **`--replace` safety** — refuses to run if the module has uncommitted git changes.
- **`detect_os`** returns `linux` or `mac`. Package managers: pacman > apt > dnf > zypper.
- **Nerd font**: CaskaydiaCove Nerd Font required by ghostty, nvim, etc. Installed per-module.
- **Opencode config** lives in `opencode/.config/opencode/opencode.jsonc`. Restart opencode sessions to pick up changes.
- **Opencode plugins** in `~/.config/opencode/plugins/` are auto-discovered; no `plugin` key needed. Verify with `opencode debug config`. None exist currently, so the directory is absent from the repo — git cannot track an empty one.
- **Session cost is context, not prose.** Measured: cache write 62.5%, cache read 29.8%, all output 7.6%; tool results are 85% of what enters context. Optimise via model choice, `compaction.prune` and `tool_output` caps — not output-style instructions.
- **No test framework, no build step, no formatter** beyond pre-commit hooks.
- **AGENTS.md is the canonical agent instructions file** — update this when adding/removing modules or changing install flow.
