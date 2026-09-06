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
| `Super-Shift-h` | Move window left |
| `Super-Shift-j` | Move window down |
| `Super-Shift-k` | Move window up |
| `Super-Shift-l` | Move window right |
| `Super-Shift-1…0` | Move window to workspace |
| `Super-mouse left` | Move window by dragging |

## Resize

| Key | Action |
|-----|--------|
| `Super-mouse right` | Resize window by dragging |
| `Super-R` | Enter resize mode (h/j/k/l to resize, Esc to exit) |

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
| `Super-Space` | App launcher (wofi) |
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
| `Super-Escape` | Lock screen |
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

## Crash recovery (safe mode)

The SDDM session runs `/usr/bin/start-hyprland`, a watchdog process. When
Hyprland exits uncleanly the watchdog relaunches it with `--safe-mode`, and
keeps that flag set for the rest of the login chain.

Safe mode does **not** load `hyprland.lua`. It writes a throwaway copy of
Hyprland's upstream example config to
`$XDG_RUNTIME_DIR/hypr/<instance>/recoverycfg.lua` and loads that instead. The
instance directory is unique per session, so this file cannot be pre-seeded or
customised — safe mode always uses upstream defaults.

| Action | Normal | Safe mode |
|--------|--------|-----------|
| Terminal | `Super-Return` (ghostty) | `Super-Q` (kitty — **not installed**) |
| Launcher | `Super-Space` (wofi) | `Super-R` (hyprland-run) |
| File manager | `Super-E` (thunar) | `Super-E` (dolphin — not installed) |
| Close window | `Super-C` | `Super-C` |
| Exit | `Super-M` | `Super-M` |

`Super-Return` and `Super-Space` are unbound in safe mode, and `Super-Q` fails
silently because kitty is not installed — which makes the session look frozen
even though it is not. Waybar and the autostart list also do not run, and the
1.5× monitor scale is not applied, so everything renders tiny at 3840x2160.

### Getting out

1. **Safe Mode dialog → "Load config"** — clears safe mode and reloads
   `hyprland.lua` in place, no logout required. Fastest route.
2. **`Super-R`** — opens the `hyprland-run` prompt; type `ghostty` for a shell.
3. **`Super-M`** — exit to SDDM, then log in again for a normal session.

`hyprctl reload` on its own does not help. The safe-mode config path stays
cached until the compositor's internal safe-mode flag is cleared, and only the
dialog button does that.

### Common cause: GPU reset

An amdgpu ring timeout resets the GPU and destroys the GL context. Hyprland
aborts deliberately in `CHyprOpenGLImpl::begin`:

```
Aborting, glGetGraphicsResetStatus returned GL_GUILTY_CONTEXT_RESET.
Cannot continue until proper GPU reset handling is implemented.
```

There is no config option or environment variable guarding this, so any GPU
reset takes the compositor down with it. To confirm that is what happened:

```bash
# what hung the GPU, and when — -b -1 is the previous boot
journalctl -k -b -1 | grep -E "ring .* timeout|Illegal opcode|GPU reset"

# Hyprland's own crash report, including the EGL error and backtrace
ls ~/.cache/hyprland/
```

A hang caused by a game is a driver or game bug, not a config problem. Capture
`/sys/class/drm/card1/device/devcoredump/data` before rebooting if you intend to
report it, since that file does not survive a reboot.

## Installation

```bash
~/dotfiles/install.sh --replace
```

Or standalone:

```bash
~/dotfiles/hyprland/scripts/install.sh
```
