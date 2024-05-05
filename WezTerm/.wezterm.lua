local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'CutiePro'
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 12.0

config.default_prog = { 'pwsh.exe', '-NoLogo' }

config.window_background_opacity = 0.95

return config
