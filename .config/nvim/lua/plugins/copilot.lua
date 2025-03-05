--return {
--  'github/copilot.vim',
--  config = function()
--    local opts = { noremap = true, silent = true }
--    vim.g.copilot_no_tab_map = true
--    -- https://github.com/github/copilot.vim/blob/1a55183ef9347d6f420406a3746474b6b9fb9ef5/doc/copilot.txt#L104
--    vim.api.nvim_set_keymap('i', '<C-f>', '<Plug>copilot#Accept("<CR>")', opts)
--    vim.api.nvim_set_keymap('i', '<C-n>', 'copilot#Next()', opts)
--    vim.api.nvim_set_keymap('i', '<C-p>', 'copilot#Previous()', opts)
--
--    -- tpope [workaround] https://github.com/community/community/discussions/16800#discussioncomment-2848953
--    -- let g:copilot_node_command = "/opt/homebrew/opt/node@16/bin/node"
--    -- it seems that the above is not needed anymore since 2023-01-06
--  end,
--}

-- enhanced version of the above
return {
  'zbirenbaum/copilot.lua',
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require('copilot').setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-h>"
        },
      },
      panel = {
        enabled = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
      },
    })
  end,
}
