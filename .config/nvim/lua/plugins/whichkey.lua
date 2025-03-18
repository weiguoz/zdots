return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>/",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "WhichKey: Global keymaps",
        },
    },
    config = function()
        local wk = require("which-key")
        wk.setup({
            win = {
                border = "rounded",
                -- row = vim.fn.line('.') + 1,
                wo = { winblend = 13 },
            },
        })
        -- wk.add({
        --   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
        -- })
    end,
}
