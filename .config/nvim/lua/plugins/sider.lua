return {
    {
        'sidebar-nvim/sidebar.nvim', -- left
        config = function()
            require("sidebar-nvim").setup({
                open = false,
                initial_width = 30,
                -- files
                -- symbols has bug: position_encoding param is required in vim.lsp.util.make_position_params. Defaulting to position encoding of the first client.
                sections = { "git", "buffers", "todos", "containers", "diagnostics" },
                section_separator = { "------", "" },
                containers = {
                    attach_shell = "/bin/sh", show_all = true, interval = 5000,
                },
                todos = { ignored_paths = { "~" } },
            })
        end
    },
    {
        'dstein64/nvim-scrollview', -- right
    },
}
