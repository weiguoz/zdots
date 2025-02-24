-- I'm using yazi.nvim instead of telescope-file-browser.nvim and neo-tree.nvim
return {
  "mikavilpas/yazi.nvim", -- dependencies: brew install yazi
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    -- {
    --   "<leader>-",
    --   mode = { "n", "v" },
    --   "<cmd>Yazi<cr>",
    --   desc = "Open yazi at the current file",
    -- },
    -- {
    --   -- Open in the current working directory
    --   "<leader>cw",
    --   "<cmd>Yazi cwd<cr>",
    --   desc = "Open the file manager in nvim's working directory",
    -- },
    -- {
    --   "<leader>f",
    --   mode = { "n", "v" },
    --   "<cmd>Yazi<cr>",
    --   desc = "Open yazi at the current file",
    -- },
    {
      "\\",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
}

-- return {
--   "nvim-telescope/telescope-file-browser.nvim",
--   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
--   config = function()
--     vim.keymap.set('n', '<leader>f', ':Telescope file_browser<cr>', { noremap = true, silent = true })
--   end,
-- }


-- -- https://github.com/nvim-neo-tree/neo-tree.nvim
-- -- neo-tree.nvim is more suitable for my needs than nvim-tree/nvim-tree.lua
-- return {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--       "MunifTanjim/nui.nvim",
--       -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
--     },
--     config = function ()
--       vim.cmd([[nnoremap \ :Neotree toggle reveal<cr>]])
--     end,
-- 
--     window = {
--       mappings = {
--         ["P"] = { "toggle_preview" },
--       }
--     },
-- }
