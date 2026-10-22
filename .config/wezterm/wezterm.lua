local term = require("wezterm")
dofile(term.config_dir .. "/" .. "./position.lua")

local themes = { "./themes/henry.lua", "./themes/anwu.lua", "./themes/w7u.lua", "./themes/xy.lua" }

local day = tonumber(os.date("%d"))
local selected_theme = themes[(day % #themes) + 1]

return dofile(term.config_dir .. "/" .. selected_theme)
