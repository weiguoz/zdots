return {
  "LintaoAmons/bookmarks.nvim", -- replace 'MattesGroeger/vim-bookmarks'
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" },        -- optional
  },
  config = function() -- bookmarks/config.lua::default_config
    require("bookmarks").setup({
      signs = {
        mark = { icon = "📌" } -- 󰃁
      },
      backup = { enable = false },
    })

    -- migrated from keymaps.lua vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
    vim.api.nvim_set_keymap('n', '<leader>bm', ':BookmarksMark<CR>', {noremap = true, silent = true, desc = "Bookmarks: add"})
    vim.api.nvim_set_keymap('n', '<leader>bl', ':BookmarksGoto<CR>', {noremap = true, silent = true, desc = "Bookmarks: list"})
    vim.api.nvim_set_keymap('n', '<leader>bt', ':BookmarksTree<CR>', {noremap = true, silent = true, desc = "Bookmarks: tree"})
    vim.api.nvim_set_keymap('n', '<leader>bc', ':BookmarksCommands<CR>', {noremap = true, silent = true, desc = "Bookmarks: command"})
    vim.api.nvim_set_keymap('n', '<leader>bp', ':BookmarksGotoPrevInList<CR>', {noremap = true, silent = true, desc = "Bookmarks: prev"})
    vim.api.nvim_set_keymap('n', '<leader>bn', ':BookmarksGotoNextInList<CR>', {noremap = true, silent = true, desc = "Bookmarks: next"})
  end,
}
