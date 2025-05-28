local function merge_table(t1, t2)
    local result = {}
    for k, v in pairs(t1) do result[k] = v end
    for k, v in pairs(t2) do result[k] = v end
    return result
end

return {
    'neovim/nvim-lspconfig',
    config = function()
        local lsp = require('lspconfig')
        -- local telescope = require('telescope.builtin')
        -- 高亮当前光标下的符号
        vim.keymap.set("n", "<leader>hh", function()
            vim.lsp.buf.document_highlight()
        end, { desc = "高亮当前符号" })

        -- 清除高亮
        vim.keymap.set("n", "<leader>hc", function()
            vim.lsp.buf.clear_references()
        end, { desc = "清除高亮" })

        local opts = { noremap = true, silent = true }
        -- lsp
        --- how telescope >
        --- https://github.com/lopi-py/nvim-config/blob/a9c2c73dbea6472adb068eb2cd9a8810322d973a/lua/lsp.lua#L23
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, merge_table(opts, { desc = "LSP: definition" }))
        vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>",
            merge_table(opts, { desc = "LSP: type definition" }))

        vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, merge_table(opts, { desc = "LSP: rename" }))
        vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, merge_table(opts, { desc = "LSP: code action" }))
        vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>",
            merge_table(opts, { desc = "LSP: implementations" }))
        vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>",
            merge_table(opts, { desc = "LSP: references" }))

        -- diagnostic
        vim.keymap.set('n', 'e', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', 'E', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>gf', vim.diagnostic.open_float,
            merge_table(opts, { desc = "Diagnostic: information" })) -- need buffer=bufnr?
        vim.keymap.set('n', '<leader>ge', "<cmd>Telescope diagnostics<cr>",
            merge_table(opts, { desc = "Diagnostic: list" }))
        -- vim.api.nvim_create_autocmd("CursorHold", {
        --     callback = function()
        --         vim.diagnostic.open_float(nil, { scope = "line", border = "rounded", focusable = false, header = "", source = "always", })
        --     end,
        -- })
        -- dl implementation 1
        -- vim.keymap.set('n', '<leader>dl', function()
        --   require('telescope.builtin').diagnostics({ severity_sort = true }) -- sort by severity
        -- end, bufopts)
        -- dl implementation 2
        -- add agnostic to loclist then export to telescope is a good idea, but the loclist popup is not good
        -- vim.keymap.set('n', '<leader>dl', function()
        --   vim.diagnostic.setloclist() -- add diagnostic to loclist
        --   telescope.loclist() -- open loclist with telescope
        -- end, bufopts)

        -- lsp: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

        local common_attach = function(_, bufnr)
            -- 保存时自动格式化
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
        -- golang
        lsp.gopls.setup({
            on_attach = common_attach,
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_dir = lsp.util.root_pattern("go.mod", ".git", "go.work"),
            settings = {
                gopls = {
                    analyses = { unreachable_code = true, unused_params = true, },
                    staticcheck = true,
                },
            }
        })
        -- c/c++
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = { "utf-16" }
        lsp.clangd.setup({
            -- force clangd to use utf-16 encoding(default is utf-8)
            -- check if all client has the same encoding:
            --   `:lua for _, client in pairs(vim.lsp.get_active_clients()) do print(client.name, client.offset_encoding) end`
            capabilities = capabilities,
            on_attach = common_attach,
            cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--background-index" },
            -- I'm going to use clangd on the remote server, but it's not working now.
            -- Remote lsp server and remote files, locally neovim toolkits.
            --
            -- 1. start clangd on the remote server. Done
            -- cmd = { "ssh", "localdocker.10510", "clangd", "--background-index", "--log=verbose", "--compile-commands-dir=/path/on/localdocker.10510" },
            -- 2. edit the files/directory on the remote server. TODO
        })
        -- bash
        lsp.bashls.setup({
            on_attach = common_attach,
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            root_dir = require('lspconfig').util.root_pattern(".git", ".bashrc", ".bash_profile"),
            settings = { bash = { diagnostics = { enable = true } } },
        })
        -- thrift
        lsp.thriftls.setup({ on_attach = common_attach })
        -- sql
        lsp.sqls.setup({ on_attach = common_attach })
        -- jsonnet
        lsp.jsonnet_ls.setup({ on_attach = common_attach })
        -- rust
        lsp.rust_analyzer.setup({ on_attach = common_attach })
        -- python
        lsp.pyright.setup({ on_attach = common_attach })
        -- lua
        lsp.lua_ls.setup({
            on_attach = common_attach,
            settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
        })
        -- ts
        lsp.ts_ls.setup({ on_attach = common_attach })
    end
}
