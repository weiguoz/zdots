local term = require("wezterm")
dofile(term.config_dir .. "/" .. "./position.lua")

local themes = { "./themes/josean.lua", "./themes/w7u.lua" } -- josean, w7u

local day = tonumber(os.date("%d"))
local selected_theme = themes[(day % #themes) + 1]
return dofile(term.config_dir .. "/" .. selected_theme)
