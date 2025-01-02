return {
  "LintaoAmons/bookmarks.nvim", -- replace 'MattesGroeger/vim-bookmarks'
  tag = "v2.4.0",
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" },        -- optional
  },
  config = function()
    require("bookmarks").setup({
      -- json_db_path = vim.fn.stdpath("config") .. "/bookmarks.db.json",
      signs = {
        mark = { icon = "📌", color = "red", line_bg = "#572626" } -- 󰃁
      },
      picker = { sort_by = "last_visited", sorting_strategy = "descending" }, -- NOTE: looks like it's not working
    })

    -- migrated from keymaps.lua vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
    vim.api.nvim_set_keymap('n', 'mm', ':BookmarksMark<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'ml', ':BookmarksGoto<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'mo', ':BookmarksCommands<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'mr', ':BookmarksGotoRecent<CR>', { noremap = true, silent = true })
  end,
}
