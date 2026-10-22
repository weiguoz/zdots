local w = require 'wezterm'

return {
    color_scheme = "Everforest Dark (Gogh)",

    font = w.font("Maple Mono NF CN"),
    font_size = 16,

    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 1500,

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = true,
    window_padding = { left = 1, right = 1, top = 0, bottom = 1 },
}
