-- Pull in the wezterm API
local wezterm = require("wezterm")

local cfg = wezterm.config_builder()

-- my coolnight colorscheme
cfg.colors = {
    foreground = "#CBE0F0",
    background = "#010423",
    cursor_bg = "#47FF9C",
    cursor_border = "#47FF9C",
    cursor_fg = "#011423",
    selection_bg = "#033259",
    selection_fg = "#CBE0F0",
    ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
    brights = { "#999", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

cfg.default_cursor_style = "BlinkingBlock" -- [Steady, Blinking]*[Block, Underline, Bar]
cfg.cursor_blink_rate = 1000

cfg.font = wezterm.font("Maple Mono")
cfg.font_size = 16


-- cfg.enable_tab_bar = false
cfg.hide_tab_bar_if_only_one_tab = true
cfg.window_decorations = "RESIZE"
cfg.initial_rows = 45
cfg.initial_cols = 135

-- NOTE: Enabling background opacity and macOS blur effects can cause color distortion.
-- This is due to system-level compositing blending the terminal background with desktop elements,
-- which affects the accuracy of truecolor gradients and smooth color rendering.
cfg.window_background_opacity = 0.85
cfg.macos_window_background_blur = 10
cfg.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }

return cfg
