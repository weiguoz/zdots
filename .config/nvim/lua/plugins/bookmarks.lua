return {
  "LintaoAmons/bookmarks.nvim", -- replace 'MattesGroeger/vim-bookmarks'
  tag = "v2.4.0",
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
      backup = { enable = false }
    })

    -- migrated from keymaps.lua vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', 'mm', ':BookmarksMark<CR>', opts)
    vim.api.nvim_set_keymap('n', 'ml', ':BookmarksGoto<CR>', opts)
    vim.api.nvim_set_keymap('n', 'mo', ':BookmarksCommands<CR>', opts)
    vim.api.nvim_set_keymap('n', 'mr', ':BookmarksGotoPrevInList<CR>', opts)
  end,
}
