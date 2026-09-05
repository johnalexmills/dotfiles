-- Hyprland Lua config (migrated from hyprland.conf, 0.54 -> 0.55+).
-- Wiki: https://wiki.hypr.land/Configuring/Start/

-- Palette (Catppuccin Mocha)
local c = require "mocha"

-- --- Autostart ---

hl.on("hyprland.start", function()
  hl.exec_cmd "/usr/lib/hyprpolkitagent/hyprpolkitagent"
  hl.exec_cmd "waybar"
  hl.exec_cmd "swaync"
  hl.exec_cmd "hyprpaper"
  hl.exec_cmd "hypridle"
  hl.exec_cmd "wl-paste --watch cliphist store"
  hl.exec_cmd "blueman-applet"
  hl.exec_cmd "mpris-proxy"
  hl.exec_cmd "hyprctl switchxkblayout all 1"
end)

-- --- Monitors ---

hl.monitor {
  output = "HDMI-A-1",
  mode = "3840x2160@120",
  position = "auto",
  scale = "1.5",
}

-- --- Default applications ---

local terminal = "ghostty"
local fileManager = "thunar"
local menu = "wofi --show drun"

-- --- XWayland scaling ---
-- force_zero_scaling keeps XWayland apps crisp on fractional scale.
-- XCURSOR_SIZE is set to (wayland cursor size * scale) = 24 * 1.5 = 36.

hl.config {
  xwayland = {
    force_zero_scaling = true,
  },
}

hl.env("XCURSOR_SIZE", "36")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_DPI_SCALE", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-dark-cursors")
hl.env("HYPRCURSOR_SIZE", "24")

-- --- Input ---

hl.config {
  input = {
    -- Two layouts: us-qwerty (games default) and us-colemak (desktop). Toggle: Alt+Shift.
    kb_layout = "us,us",
    kb_variant = ",colemak",
    kb_options = "ctrl:nocaps,grp:alt_shift_toggle",

    resolve_binds_by_sym = true,
    follow_mouse = 1,
    accel_profile = "flat",
    sensitivity = 0,
    natural_scroll = true,

    touchpad = {
      natural_scroll = true,
    },
  },
}

-- --- Appearance ---

hl.config {
  general = {
    border_size = 3,
    col = {
      active_border = { colors = { c.mauve, c.flamingo }, angle = 90 },
      inactive_border = c.surface0,
    },
    resize_on_border = true,
    gaps_in = 2,
    gaps_out = 4,
    layout = "dwindle",
    allow_tearing = false,
  },

  decoration = {
    rounding = 4,

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
    },

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },
  },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },
}

-- Subtle, snappy animations.

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation { leaf = "windows", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" }
hl.animation { leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" }
hl.animation { leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" }
hl.animation { leaf = "windowsMove", enabled = true, speed = 3, bezier = "easeOutQuint" }
hl.animation { leaf = "fade", enabled = true, speed = 4, bezier = "easeOutQuint" }
hl.animation { leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" }
hl.animation { leaf = "border", enabled = true, speed = 10, bezier = "easeOutQuint" }
hl.animation { leaf = "borderangle", enabled = true, speed = 50, bezier = "linear", style = "loop" }

-- Gesture: 3-finger horizontal swipe to switch workspaces.
hl.gesture { fingers = 3, direction = "horizontal", action = "workspace" }

-- --- Window / layer rules ---

hl.window_rule {
  name = "suppress-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
}

hl.window_rule {
  match = { class = "^(pavucontrol|nm-connection-editor)$" },
  float = true,
}

hl.window_rule {
  match = { class = "^(xdg-desktop-portal-gtk)$" },
  float = true,
}

hl.window_rule {
  match = { class = "^(blueman-manager)$" },
  float = true,
}

hl.window_rule {
  match = { title = "^(Picture-in-Picture)$" },
  float = true,
}

hl.layer_rule { match = { namespace = "^(waybar)$" }, blur = true }
hl.layer_rule { match = { namespace = "^(swaync-control-center)$" }, blur = true }
hl.layer_rule { match = { namespace = "^(swaync-notification-window)$" }, blur = true }
hl.layer_rule { match = { namespace = "^(wofi)$" }, no_anim = true }

-- --- Keybinds ---

local mainMod = "SUPER"

-- Launchers
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd "steam -cef-disable-gpu")

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float { action = "toggle" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout "togglesplit")
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Focus (vim-style)
hl.bind(mainMod .. " + h", hl.dsp.focus { direction = "left" })
hl.bind(mainMod .. " + j", hl.dsp.focus { direction = "down" })
hl.bind(mainMod .. " + k", hl.dsp.focus { direction = "up" })
hl.bind(mainMod .. " + l", hl.dsp.focus { direction = "right" })

-- Move window
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move { direction = "left" })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move { direction = "down" })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move { direction = "up" })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move { direction = "right" })

-- Workspaces
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus { workspace = i })
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move { workspace = i })
end

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus { workspace = "e+1" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus { workspace = "e-1" })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd "hyprshot -m window")
hl.bind("SHIFT + Print", hl.dsp.exec_cmd "hyprshot -m region")
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd "hyprshot -m region --clipboard-only")

-- Clipboard history
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd "cliphist list | wofi --show dmenu | cliphist decode | wl-copy")

-- Wallpaper picker (wofi-driven; uses ~/.config/backgrounds/)
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(os.getenv "HOME" .. "/.config/hypr/wallpaper.sh"))

-- System
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd "hyprctl switchxkblayout all 1 && hyprlock")
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd "systemctl suspend")
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd "systemctl poweroff")
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd "systemctl reboot")
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.exec_cmd "hyprctl reload")
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- Resize submap: Super+R, then h/j/k/l to resize, Escape to exit
hl.bind(mainMod .. " + R", hl.dsp.submap "resize")

hl.define_submap("resize", function()
  hl.bind("h", hl.dsp.window.resize { x = -10, y = 0, relative = true })
  hl.bind("l", hl.dsp.window.resize { x = 10, y = 0, relative = true })
  hl.bind("j", hl.dsp.window.resize { x = 0, y = 10, relative = true })
  hl.bind("k", hl.dsp.window.resize { x = 0, y = -10, relative = true })
  hl.bind("Escape", hl.dsp.submap "reset")
end)

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd "pactl set-sink-volume @DEFAULT_SINK@ +10%")
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd "pactl set-sink-volume @DEFAULT_SINK@ -10%")
hl.bind("XF86AudioMute", hl.dsp.exec_cmd "pactl set-mute @DEFAULT_SINK@ toggle")
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd "brightnessctl set +5%")
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd "brightnessctl set 5%-")
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd "playerctl play-pause")
hl.bind("XF86AudioNext", hl.dsp.exec_cmd "playerctl next")
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd "playerctl previous")
hl.bind("XF86AudioStop", hl.dsp.exec_cmd "playerctl stop")
