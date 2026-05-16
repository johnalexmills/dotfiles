# Hyprland

A dynamic tiling Wayland compositor with Catppuccin Mocha theme.

**Mod key:** `Super` (Windows/Command)

## Focus

| Key | Action |
|-----|--------|
| `Super-h` | Focus left |
| `Super-j` | Focus down |
| `Super-k` | Focus up |
| `Super-l` | Focus right |

## Move Window

| Key | Action |
|-----|--------|
| `Super-Shift-1…0` | Move window to workspace |

## Resize

| Key | Action |
|-----|--------|
| `Super-mouse right` | Resize window |
| `Super-mouse left` | Move window |

## Layout

| Key | Action |
|-----|--------|
| `Super-F` | Toggle fullscreen |
| `Super-V` | Toggle floating |
| `Super-P` | Pseudo-tile (dwindle) |
| `Super-E` | Toggle split (dwindle) |
| `Super-W` | Toggle group |

## Workspaces

| Key | Action |
|-----|--------|
| `Super-1…0` | Switch to workspace |
| `Super-Shift-1…0` | Move window to workspace |
| `Super-S` | Toggle scratchpad |

## Launcher

| Key | Action |
|-----|--------|
| `Super-Space` | App launcher (wofi) |
| `Super-Return` | Terminal (ghostty) |

## Media Keys

| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume +10% |
| `XF86AudioLowerVolume` | Volume -10% |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp` | Brightness +5% |
| `XF86MonBrightnessDown` | Brightness -5% |

## Screenshots

| Key | Action |
|-----|--------|
| `Print` | Screenshot window |
| `Shift-Print` | Screenshot region |

## System

| Key | Action |
|-----|--------|
| `Super-Shift-L` | Lock screen |
| `Super-Shift-R` | Reload Hyprland config |
| `Super-C` | Close active window |
| `Super-M` | Exit Hyprland |

## Gaming

```bash
# Launch a game with FSR upscaling (e.g. 1080p -> 1440p)
gamescope -f -W 1920 -H 1080 -- <game>

# Show performance overlay
mangohud <game>

# Use gamemode for optimized performance
gamemoderun <game>
```

## Installation

```bash
~/dotfiles/install.sh --replace
```

Or standalone:

```bash
~/dotfiles/hyprland/scripts/install.sh
```
