return {
    {
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
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("treesitter-context").setup({ max_lines = 4 })

            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true, desc = "treesitter-context: up" })
        end,
    },
}
