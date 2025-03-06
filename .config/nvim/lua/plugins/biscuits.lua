return {
  'code-biscuits/nvim-biscuits',
  config = function()
    require('nvim-biscuits').setup({
      toggle_keybind = "<leader>bi",
      -- show_on_start = true,
      cursor_line_only = true,
      default_config = {
        max_length = 12,
        min_distance = 5,
        prefix_string = "🌈", -- 📎 🌐
      },
    })
  end
}
