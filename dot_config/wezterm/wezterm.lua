local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('JetBrains Mono', { weight = 'Bold' })
config.freetype_load_target = 'HorizontalLcd'
config.freetype_load_flags = 'DEFAULT'

return config
