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
    vim.api.nvim_set_keymap('n', '<leader>ma', ':BookmarksMark<CR>', {noremap = true, silent = true, desc = "Bookmarks add"})
    vim.api.nvim_set_keymap('n', '<leader>ml', ':BookmarksGoto<CR>', {noremap = true, silent = true, desc = "Bookmarks list"})
    vim.api.nvim_set_keymap('n', '<leader>mc', ':BookmarksCommands<CR>', {noremap = true, silent = true, desc = "Bookmarks commands"})
    vim.api.nvim_set_keymap('n', '<leader>mp', ':BookmarksGotoPrevInList<CR>', {noremap = true, silent = true, desc = "Bookmarks prev"})
    vim.api.nvim_set_keymap('n', '<leader>mn', ':BookmarksGotoNextInList<CR>', {noremap = true, silent = true, desc = "Bookmarks next"})
  end,
}
