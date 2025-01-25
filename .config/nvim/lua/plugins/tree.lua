-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- neo-tree.nvim is more suitable for my needs than nvim-tree/nvim-tree.lua
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function ()
        vim.cmd([[nnoremap \ :Neotree toggle reveal<cr>]])
    end
}
