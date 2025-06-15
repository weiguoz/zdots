local wezterm = require 'wezterm'

return {
    color_scheme = "Snazzy (Gogh)", -- Dracula Rapture "Snazzy (Gogh)" synthwave-everything

    font = wezterm.font("Maple Mono"),
    font_size = 16,

    colors = { cursor_fg = "#000000", cursor_bg = "#D20F39" },
    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 900,

    background = {
        {
            -- https://alphacoders.com/nebula-wallpapers
            source = { File = wezterm.home_dir .. "/Pictures/terminal_bg.jpg" },
            opacity = 0.8,
            attachment = "Fixed",
        },
    },

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE",    -- hide TITLE
    macos_window_background_blur = 8, -- blur background

    hide_tab_bar_if_only_one_tab = true,
}
