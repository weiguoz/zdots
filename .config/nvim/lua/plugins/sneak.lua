-- vim-sneak replace easymotion
-- " Search paste is broken, so I removed the plugin.
-- " More details https://github.com/easymotion/vim-easymotion/issues/408
-- let g:EasyMotion_smartcase = 1 " Turn on case-insensitive feature
-- map  / <Plug>(easymotion-sn)
-- omap / <Plug>(easymotion-tn)
-- nmap , <Plug>(easymotion-bd-jk)
-- " nmap ; <Plug>(easymotion-lineanywhere)
-- " <Plug>(easymotion-jumptoanywhere)
return {
  'justinmk/vim-sneak',
  config = function()
    vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_f', {noremap = true, silent = true, desc = "Sneak f: find"})
    -- vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_F', {})
  end
}
