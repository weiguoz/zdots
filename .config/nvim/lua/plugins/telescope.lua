return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
        mappings = {
          -- close on single escape or double escape
          i = { ['<Esc>'] = require('telescope.actions').close },
          -- n = { ['<Esc>'] = require('telescope.actions').close },
        },
      },
    }

    vim.keymap.set('n', 't', '<cmd>Telescope<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', 'c', '<cmd>Telescope commands<cr>', { noremap = true, silent = true })
  end,
}
