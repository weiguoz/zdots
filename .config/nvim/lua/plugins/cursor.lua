-- vim.opt.guicursor = {
--     "n-v-c:block-blinkwait300-blinkon200-blinkoff150",
--     "i:ver15-blinkwait200-blinkon150-blinkoff100",
-- }

return {
    -- {
    --     "gen740/SmoothCursor.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("smoothcursor").setup({
    --             type = "default",
    --             fancy = { enable = true },
    --         })
    --     end,
    -- },
    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            particles_enabled = true,
            particle_spread = 1,
            particles_per_second = 300,
            particles_per_length = 20,
            particle_max_lifetime = 400,
            particle_max_initial_velocity = 15,
            particle_velocity_from_cursor = 0.4,
            particle_gravity = -20,
            never_draw_over_target = true,
            hide_target_hack = true,
        }
    },
}
