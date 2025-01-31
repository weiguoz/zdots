return {
    'inkarkat/vim-mark',
    dependencies = { 'inkarkat/vim-ingo-library' },
    config = function()
        vim.api.nvim_set_keymap('n', '<leader>M', ':MarkClear<CR>', { noremap = true, silent = true })
    end,
}
