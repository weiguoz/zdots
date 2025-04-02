return {
    'github/copilot.vim',
    config = function()
        local opts = { silent = true }
        vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false
        })
        -- https://github.com/github/copilot.vim/blob/a9228e015528c9307890c48083c925eb98a64a79/doc/copilot.txt#L119
        vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)', opts) -- must not c-w which is used as delete a back word
        vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', opts)
        vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', opts)
        vim.keymap.set('i', '<C-x>', '<Plug>(copilot-dismiss)', opts)

        -- tpope [workaround] https://github.com/community/community/discussions/16800#discussioncomment-2848953
        -- let g:copilot_node_command = "/opt/homebrew/opt/node@16/bin/node"
        -- it seems that the above is not needed anymore since 2023-01-06
        vim.g.copilot_no_tab_map = true
    end,
}

-- 'zbirenbaum/copilot.lua' collpased twice recently, so i turn back to github version(tpope)
-- 1) https://github.com/zbirenbaum/copilot.lua/issues/408
-- 2) others
-- return {
--     'zbirenbaum/copilot.lua',
--     cmd = "Copilot",
--     event = "InsertEnter",
--     config = function()
--         require('copilot').setup({
--             suggestion = {
--                 enabled = true,
--                 auto_trigger = true,
--                 debounce = 75,
--                 keymap = {
--                     accept = "<C-f>",
--                     next = "<C-j>",
--                     prev = "<C-k>",
--                     dismiss = "<C-x>"
--                 },
--             },
--             panel = {
--                 enabled = true,
--                 keymap = {
--                     jump_prev = "[[",
--                     jump_next = "]]",
--                     accept = "<CR>",
--                     refresh = "gr",
--                     open = "<M-CR>"
--                 },
--             },
--         })
--     end,
-- }
