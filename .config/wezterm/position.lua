local wezterm = require 'wezterm'

wezterm.on('gui-startup', function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {}) -- tab pane window

    local gui_window = window:gui_window()
    local screen = wezterm.gui.screens().main
    local dims = gui_window:get_dimensions()

    local x = screen.x + (screen.width - dims.pixel_width)*13/21
    local y = screen.y + (screen.height - dims.pixel_height)*13/21

    gui_window:set_position(x, y)
end)
