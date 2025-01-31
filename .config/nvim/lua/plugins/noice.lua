return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },

    require("noice").setup({
      cmdline = {
        view = "cmdline_popup",
        format = {
            cmdline = { pattern = "^:", icon = "", title = "Command" }, -- pattern = "^[:/?]" commandline, search_down, search_up
          },
      },
      messages = { enabled = true },
      popupmenu = { enabled = true, backend = "nui" },
      lsp = {
        progress = { enabled = true },
        hover = { enabled = true },
        signature = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { width = "60%", height = "auto" },
          border = { style = "rounded", padding = { 1, 2 } },
          win_options = { winblend = 7, winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
        },
      },
    })
}
