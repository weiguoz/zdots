vim.opt.guicursor = {
    "n-v-c:block-blinkwait300-blinkon200-blinkoff150",
    "i:ver15-blinkwait200-blinkon150-blinkoff100",
}

return {
    {
        "gen740/SmoothCursor.nvim",
        event = "VeryLazy",
        config = function()
            require("smoothcursor").setup({
                type = "default",
                fancy = { enable = true },
            })
        end,
    },
    -- {
    --     "sphamba/smear-cursor.nvim",
    --     event = "VeryLazy",
    --     opts = { cursor_color = "#d3cdc3" },
    -- },
}
