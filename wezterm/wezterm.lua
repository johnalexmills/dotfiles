-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "rose-pine"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.0
config.enable_tab_bar = false
config.check_for_updates = false
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 2,
}
-- config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
-- and finally, return the configuration to wezterm
return config
