# Hyprland

A dynamic tiling Wayland compositor with Catppuccin Mocha theme.

**Mod key:** `Super` (Windows/Command)

**Keyboard layouts:** QWERTY (primary) and Colemak — toggle with `Alt+Shift`

**Mouse:** Flat acceleration profile, natural scrolling enabled

**Display:** 1.5× scale (XWayland forced to 1.0; `XCURSOR_SIZE=36` compensates)

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
| `Super-mouse left` | Move window by dragging |

## Resize

| Key | Action |
|-----|--------|
| `Super-mouse right` | Resize window by dragging |

## Layout

| Key | Action |
|-----|--------|
| `Super-F` | Toggle fullscreen |
| `Super-V` | Toggle floating |
| `Super-P` | Pseudo-tile (dwindle) |
| `Super-T` | Toggle split (dwindle) |
| `Super-W` | Toggle group |

## Workspaces

| Key | Action |
|-----|--------|
| `Super-1…0` | Switch to workspace |
| `Super-Shift-1…0` | Move window to workspace |
| `Super-scroll` | Scroll through workspaces |

## Launcher & Apps

| Key | Action |
|-----|--------|
| `Alt-Space` | App launcher (wofi) |
| `Super-Return` | Terminal (ghostty) |
| `Super-E` | File manager (thunar) |
| `Super-G` | Steam |

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
| `Ctrl-Shift-Print` | Screenshot region to clipboard |

## Clipboard

| Key | Action |
|-----|--------|
| `Super-Shift-V` | Clipboard history picker (cliphist + wofi) |

## Wallpaper

| Key | Action |
|-----|--------|
| `Super-Shift-W` | Wallpaper picker (lists `~/.config/backgrounds/`) |

Drop wallpapers into `~/.config/backgrounds/` and use the picker, or pass a
path/URL directly:

```bash
~/.config/hypr/wallpaper.sh ~/Pictures/some.jpg
~/.config/hypr/wallpaper.sh https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/astronaut.png
```

The script copies the chosen image to `~/.config/backgrounds/wallpaper` (used by
both Hyprpaper and Hyprlock) and live-reloads Hyprpaper via IPC.

Browse the catppuccin-mocha wallpaper gallery at
<https://orangc.net/wallsppuccin/> or
<https://github.com/orangci/walls-catppuccin-mocha>.

## System

| Key | Action |
|-----|--------|
| `Super-C` | Close active window |
| `Super-M` | Exit Hyprland (back to SDDM) |
| `Super-Shift-L` | Lock screen |
| `Super-Shift-P` | Poweroff |
| `Super-Shift-R` | Reboot |
| `Super-Shift-S` | Suspend |
| `Super-Shift-.` | Reload Hyprland config |

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
