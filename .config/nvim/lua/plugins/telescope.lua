return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
      },
    }

    vim.keymap.set('n', 't', '<cmd>Telescope<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', 'c', '<cmd>Telescope commands<cr>', { noremap = true, silent = true })
  end,
}
