local config_files = { "josean.lua", "w7u.lua" }

local day = tonumber(os.date("%d"))
local selected_config = config_files[(day % #config_files) + 1]
return dofile(require("wezterm").config_dir .. "/" .. selected_config)
