return {
  'justinmk/vim-sneak',
  config = function()
    vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_f', {})
    -- vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_F', {})
  end
}
