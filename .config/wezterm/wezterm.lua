local wezterm = require 'wezterm'

return {
    color_scheme = "Dracula", -- "Rapture", "Horizon", "Banana BlueBerry", "Snazzy Soft"
    hide_tab_bar_if_only_one_tab = true,

    font = wezterm.font("Maple Mono"),
    font_size = 15.0,

    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 800,
    colors = {
        cursor_fg = "#000000",
        cursor_bg = "#D20F39",
    },

    background = {
        {
            -- https://alphacoders.com/nebula-wallpapers
            source = { File = wezterm.home_dir .. "/Pictures/terminal_bg.jpg" },
            opacity = 0.95,
            attachment = "Fixed",
        },
    },

    initial_rows = 45,
    initial_cols = 135,
}
