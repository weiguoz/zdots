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
            -- :Noice history<enter> to display the history of messages
            routes = {
                {
                    view = "notify", -- nvim-notify 的事件系统
                    filter = {
                        event = "notify",
                        kind = "info",
                        find = "No code actions available",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",          -- vim 消息事件
                        any = {
                            { find = "%d+L, %d+B" }, -- written
                            -- { find = "; after #%d+" },
                            -- { find = "; before #%d+" },
                            -- { find = "%d+ more lines" },
                            -- { find = "%d+ fewer lines" },
                        },
                    },
                    opts = { skip = true },
                }
            }
        })

        vim.keymap.set({ "n", "s" }, "<Esc>", function()
            if noice.api.status.message.has() then
                noice.cmd("dismiss")
            end
        end, { silent = true, noremap = true, desc = "Dismiss Noice message" })

        require("notify").setup({ background_colour = "#1e1e2e" })
    end,
}
