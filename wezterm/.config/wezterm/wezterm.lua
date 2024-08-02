local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_kitty_keyboard = true
config.font_size = 12

return config
