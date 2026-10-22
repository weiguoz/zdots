local w = require("wezterm")
local utils = dofile(w.config_dir .. "/utils.lua")

local config = {
    color_scheme = utils.scheme_light_or_dark(w, "Whimsy", "Catppuccin Mocha"),

    font = w.font("Maple Mono NF CN"),
    font_size = 16,

    default_cursor_style = "BlinkingBar", -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
    cursor_blink_rate = 1500,

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = true,
}

return config
