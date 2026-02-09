function GitBcommitsOnCursor()
    local file = vim.fn.expand('%')
    local line = vim.api.nvim_win_get_cursor(0)[1]
    -- dependency: telescope.nvim
    require('telescope.builtin').git_bcommits_range({
        from = line,
        to = line,
        file = file,
        previewer = true,
        shorten_path = true,
        attach_mappings = function(_, map) -- _ = prompt_bufnr
            -- disable enter key to step into commit
            local actions = require('telescope.actions')
            map('i', '<CR>', actions.close)
            map('n', '<CR>', actions.close)
            return true
        end,
    })
end

vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua pcall(GitBcommitsOnCursor)<CR>',
    { noremap = true, silent = true, desc = "Git commits on cursor" })

return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- end of line
                delay = 200,
            },

            -- https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#keymaps
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end
                -- Navigation
                map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
                map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
            end,
        }
    end,
}
