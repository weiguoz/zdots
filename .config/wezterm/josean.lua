-- Pull in the wezterm API
local wezterm = require("wezterm")

local cfg = wezterm.config_builder()

-- my coolnight colorscheme
cfg.colors = {
    foreground = "#CBE0F0",
    background = "#011423",
    cursor_bg = "#47FF9C",
    cursor_border = "#47FF9C",
    cursor_fg = "#011423",
    selection_bg = "#033259",
    selection_fg = "#CBE0F0",
    ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
    brights = { "#aaa", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

cfg.default_cursor_style = "BlinkingBar" -- [Steady, Blinking]*[Block, Underline, Bar]
cfg.cursor_blink_rate = 900

cfg.font = wezterm.font("Maple Mono")
cfg.font_size = 15

cfg.window_decorations = "RESIZE"
cfg.window_background_opacity = 0.85
cfg.enable_tab_bar = false

cfg.macos_window_background_blur = 10
cfg.initial_rows = 45
cfg.initial_cols = 135

return cfg
