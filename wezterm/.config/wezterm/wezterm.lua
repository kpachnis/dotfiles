local wezterm = require 'wezterm'

local config = wezterm.config_builder()


config.color_scheme = 'NvimLight'
config.enable_kitty_keyboard = true
config.font_size = 12

return config
