local themes = { "./themes/josean.lua", "./themes/w7u.lua" }

local day = tonumber(os.date("%d"))
local selected_theme = themes[(day % #themes) + 1]
return dofile(require("wezterm").config_dir .. "/" .. selected_theme)
