local term = require("wezterm")
dofile(term.config_dir .. "/" .. "./position.lua")

local day = tonumber(os.date("%d"))
local themes = { "./themes/henry.lua", "./themes/anwu.lua", "./themes/w7u.lua", "./themes/xy.lua" }
local selected_theme = themes[(day % #themes) + 1]
local cfg = dofile(term.config_dir .. "/" .. selected_theme)

local apply_custom_keys = dofile(term.config_dir .. "/" .. "./custom_keys.lua")
return apply_custom_keys(cfg)
