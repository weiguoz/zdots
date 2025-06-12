return {
    "wfxr/minimap.vim",
    build = "brew install code-minimap",
    dependencies = {
        { 'dstein64/nvim-scrollview' }, -- fake dependency
    },
    init = function()
        vim.g.minimap_width = 7
        vim.g.minimap_auto_start = 1
        vim.g.minimap_auto_start_win_enter = 1
    end,
}
