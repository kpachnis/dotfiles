local wezterm = require 'wezterm'

local config = wezterm.config_builder()


config.color_scheme = 'Modus-Operandi'
config.enable_kitty_keyboard = true

return config
