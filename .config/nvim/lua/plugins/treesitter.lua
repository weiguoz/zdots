return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },

  config = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "go", "c", "cpp", "java", "python", "bash", "sql", "thrift", "json", "jsonnet", "yaml", "toml", "tmux", "markdown", "rust", "javascript", "typescript", "html" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
    })
  end,
}
