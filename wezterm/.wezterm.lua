local wezterm = require 'wezterm'

local config = wezterm.config_builder()


config.color_scheme = 'catppuccin-frappe'
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.enable_kitty_keyboard = true

return config
