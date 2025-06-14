return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "?<leader>", -- "<leader>/",
            function()
                require("which-key").show("<leader>")
            end,
            desc = "keymaps: leader+ ",
        },
        {
            "?g",
            function()
                require("which-key").show("g")
            end,
            desc = "keymaps: g+ ",
        },
        {
            "?z",
            function()
                require("which-key").show("z")
            end,
            desc = "keymaps: z+ ",
        },
        {
            "?d",
            function()
                require("which-key").show("d")
            end,
            desc = "keymaps: d+ ",
        },
        {
            "?v",
            function()
                require("which-key").show("v")
            end,
            desc = "keymaps: v+ (work just hit v)",
        }
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
