return {
    {
        'sidebar-nvim/sidebar.nvim', -- left
        config = function()
            local sidebar = require("sidebar-nvim")
            sidebar.setup({
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

            local sidebar_opened_once = false
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "go", "c", "cpp", "python", "javascript",
                    "typescript", "rust", "sql", "thrift", "lua", "sh" },
                callback = function()
                    if not sidebar_opened_once and not sidebar.is_open() then
                        sidebar_opened_once = true
                        vim.defer_fn(function() sidebar.open() end, 100) -- 延迟 100ms 调用，以避免初始化冲突
                    end
                end,
            })
        end
    },
    {
        'dstein64/nvim-scrollview', -- right
    },
}
