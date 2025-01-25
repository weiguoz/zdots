return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set('n', '<leader>f', ':Telescope file_browser<cr>', { noremap = true, silent = true })
  end,
}
