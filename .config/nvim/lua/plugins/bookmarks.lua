return {
  -- 'MattesGroeger/vim-bookmarks' was replaced by 'LintaoAmons/bookmarks.nvim'
  "LintaoAmons/bookmarks.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" },        -- optional
  },
  config = function()
    require("bookmarks").setup({
      json_db_path = vim.fn.stdpath("config") .. "/bookmarks.db.json",
      signs = {
        mark = { icon = "♥", color = "red", line_bg = "#572626" },
      },
      picker = {
        sort_by = "last_visited",
      },
      enable_backup = true,
      show_calibrate_result = true,
      auto_calibrate_cur_buf = true,
      treeview = {
        bookmark_format = function(bookmark)
          return bookmark.name ~= "" and bookmark.name or "[No Name]"
        end,
        keymap = {
          quit = { "q", "<ESC>" },
          refresh = "R",
          create_folder = "a",
          tree_cut = "x",
          tree_paste = "p",
          collapse = "o",
          delete = "d",
          active = "s",
          copy = "c",
        },
      },
      hooks = {
        {
          callback = function(bookmark, projects)
            local project_path
            for _, p in ipairs(projects) do
              if p.name == bookmark.location.project_name then
                project_path = p.path
              end
            end
            if project_path then
              vim.cmd("cd " .. project_path)
            end
          end,
        },
      },
    })
  end,
}
