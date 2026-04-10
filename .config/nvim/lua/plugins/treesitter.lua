return {
  {
    -- brew install tree-sitter-cli
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua", "go", "c", "cpp", "java", "python", "bash",
        "thrift", "json", "jsonnet", "yaml", "toml", "markdown",
        "tmux", "rust", "javascript", "typescript", "html",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    opts = {
      max_lines = 4,
    },
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        silent = true,
        desc = "treesitter-context: up",
      },
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", {
        bg = "#ff99ff",
        fg = "#1a1a1a",
        underline = false,
      })
    end,
  },
}
