return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local noice = require("noice")
        noice.setup({
            cmdline = {
                view = "cmdline_popup",
                format = { cmdline = { pattern = "^:", icon = "", title = "Command" } },
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
                    position = { row = "61.8%", col = "50%" },
                    size = { width = 60, height = "auto" },
                    border = { style = "rounded", padding = { 1, 2 } },
                    win_options = { winblend = 0, winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
                },
            },
        })

        vim.keymap.set({ "n", "s" }, "<Esc>", function()
            if noice.api.status.message.has() then
                noice.cmd("dismiss")
            end
        end, { silent = true, noremap = true, desc = "Dismiss Noice message" })

        require("notify").setup({ background_colour = "#1e1e2e" })
    end,
}
