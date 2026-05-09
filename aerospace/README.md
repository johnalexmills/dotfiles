# AeroSpace

A tiling window manager for macOS with Colemak keybindings.

**Directions:** `m` = left, `n` = down, `e` = up, `o` = right

## Focus

| Key | Action |
|-----|--------|
| `alt-m` | Focus left |
| `alt-n` | Focus down |
| `alt-e` | Focus up |
| `alt-o` | Focus right |

## Move Window

| Key | Action |
|-----|--------|
| `alt-shift-m` | Move window left |
| `alt-shift-n` | Move window down |
| `alt-shift-e` | Move window up |
| `alt-shift-o` | Move window right |

## Resize

| Key | Action |
|-----|--------|
| `alt-minus` | Shrink window |
| `alt-equal` | Grow window |

## Layout

| Key | Action |
|-----|--------|
| `alt-slash` | Toggle tiles layout |
| `alt-comma` | Toggle accordion layout |
| `alt-f` | Toggle fullscreen |
| `alt-shift-f` | Toggle float / tiling |

## Workspaces

| Key | Action |
|-----|--------|
| `alt-1` … `alt-9` | Switch to workspace |
| `alt-shift-1` … `alt-shift-9` | Move window to workspace |
| `alt-tab` | Previous workspace |
| `alt-shift-tab` | Move workspace to next monitor |

## General

| Key | Action |
|-----|--------|
| `alt-shift-q` | Close window |
| `alt-shift-semicolon` | Reload config |
| `alt-shift-s` | Enter service mode |

## Service Mode

Press `alt-shift-s` to enter, then:

| Key | Action |
|-----|--------|
| `esc` | Exit service mode |
| `r` | Flatten workspace tree |
| `backspace` | Close all windows but current |
| `alt-shift-m/n/e/o` | Join window with neighbour |

## Installation

```bash
~/dotfiles/install.sh
```

Or just the aerospace module:

```bash
~/dotfiles/aerospace/scripts/install.sh
```
