return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = { theme = 'auto' },                                -- { theme = 'PaperColor' },
            extensions = { 'lazy', 'nvim-dap-ui', 'quickfix', 'mundo' }, -- remove 'nvim-tree' extensions, replaced by yazi
            -- in fact, the filename supplied by 'dropbar.lua' is not enough
            sections = { lualine_c = { { 'filename', path = 1 } } },
        })
    end,
}
