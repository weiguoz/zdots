return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "go", "c", "cpp", "java", "python", "bash",
          "sql", "thrift", "json", "jsonnet", "yaml", "toml",
          "tmux", "rust", "javascript", "typescript", "html",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    config = function()
      require("treesitter-context").setup({ max_lines = 4 })

      vim.keymap.set("n", "[k", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true, desc = "treesitter-context: up" })

      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", {
        bg = "#ff99ff",
        fg = "#1a1a1a",
        underline = false,
      })
    end,
  },
}
