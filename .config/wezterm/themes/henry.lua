local w = require 'wezterm'
local utils = dofile(w.config_dir .. "/utils.lua")

return {
    color_scheme = utils.scheme_dark_or_light(w, "Everforest Dark (Gogh)", "Everforest Light (Gogh)"),

    font = w.font("Maple Mono NF CN"),
    font_size = 16,

    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 1500,

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = true,
    window_padding = { left = 0, right = 0, top = 0, bottom = 1 },
}
