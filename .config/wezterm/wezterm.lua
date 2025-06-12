local wezterm = require 'wezterm'

return {
    color_scheme = "Dracula", -- "Rapture", "Horizon", "Banana BlueBerry", "Snazzy Soft"

    font = wezterm.font("Maple Mono"),
    font_size = 15.0,

    colors = { cursor_fg = "#000000", cursor_bg = "#D20F39" },
    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 800,

    background = {
        {
            -- https://alphacoders.com/nebula-wallpapers
            source = { File = wezterm.home_dir .. "/Pictures/terminal_bg.jpg" },
            opacity = 0.9,
            attachment = "Fixed",
        },
    },

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE",    -- hide TITLE
    macos_window_background_blur = 7, -- blur background

    hide_tab_bar_if_only_one_tab = true,
}
