return {
  "rhysd/git-messenger.vim",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>gm', ':GitMessenger<CR>', { noremap = true, silent = true })

    vim.g.git_messenger_popup = 1
    vim.g.git_messenger_commit_popup = 1
    vim.g.git_messenger_max_width = 60
  end
}
