return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('nvim-tree').setup {
      view = {
          width = { min = 20, max = 70},
          relativenumber = true,
      },
    }

    vim.keymap.set('n', '<leader>e', ':NvimTreeFindFile<cr>', { noremap = true, silent = true })
  end,
}
