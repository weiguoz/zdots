local wezterm = require 'wezterm'

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Whimsy"
  end
end

local config = {
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

    font = wezterm.font("Maple Mono NF CN"),
    font_size = 16,

    default_cursor_style = "BlinkingBar", -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
    cursor_blink_rate = 1500,

    initial_rows = 45,
    initial_cols = 135,
    window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = true,
}

return config
