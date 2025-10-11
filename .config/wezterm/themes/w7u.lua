local wezterm = require 'wezterm'

return {
    color_scheme = "Snazzy (Gogh)", -- Dracula Rapture "Snazzy (Gogh)" synthwave-everything

    font = wezterm.font("Maple Mono"),
    font_size = 16,

    colors = { cursor_fg = "#011423", cursor_bg = "#47FF9C" },
    default_cursor_style = "BlinkingBlock", -- [Steady, Blinking]*[Block, Underline, Bar]
    cursor_blink_rate = 1500,

    -- background = {
    --     {
    --         -- https://alphacoders.com/nebula-wallpapers
    --         source = { File = wezterm.home_dir .. "/Pictures/terminal_bg.jpg" },
    --         opacity = 0.9,
    --         attachment = "Fixed",
    --     },
    -- },

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE", -- hide TITLE
    hide_tab_bar_if_only_one_tab = true,

    macos_window_background_blur = 10, -- blur background

    -- 设置窗口边距为 0（边框效果最小化）
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
}
