local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'IosevkaTerm Nerd Font Mono'

config.color_scheme = "tokyonight_night"
config.enable_kitty_keyboard = true
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true
config.font_size = 14

return config

