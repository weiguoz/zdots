local function merge_table(t1, t2)
    local res = {}
    for k, v in pairs(t1) do res[k] = v end
    for k, v in pairs(t2) do res[k] = v end
    return res
end

return {
    'neovim/nvim-lspconfig',
    config = function()
        -- ====== 通用按键 ======
        vim.keymap.set("n", "<leader>hh", function() vim.lsp.buf.document_highlight() end, { desc = "高亮当前符号" })
        vim.keymap.set("n", "<leader>hc", function() vim.lsp.buf.clear_references() end, { desc = "清除高亮" })

        local opts = { noremap = true, silent = true }
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

        vim.keymap.set('n', 'e', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', 'E', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>gf', vim.diagnostic.open_float, merge_table(opts, { desc = "Diagnostic: information" }))
        vim.keymap.set('n', '<leader>ge', "<cmd>Telescope diagnostics<cr>", merge_table(opts, { desc = "Diagnostic: list" }))

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

        -- ====== 公共 on_attach ======
        local common_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end

        -- ====== Go: gopls（你已改好的，保持原逻辑）======
        vim.lsp.config("gopls", {
            on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
            settings = {
                gopls = {
                    analyses = { unreachable_code = true, unused_params = true },
                    staticcheck = true,
                },
            }
        })
        vim.lsp.enable('gopls')

        -- ====== C/C++: clangd（顺序：先 config 再 enable）======
        local clang_cap = vim.lsp.protocol.make_client_capabilities()
        clang_cap.offsetEncoding = { "utf-16" }

        vim.lsp.config("clangd", {
            capabilities = clang_cap,
            on_attach = common_attach,
            -- force clangd to use utf-16 encoding(default is utf-8)
            -- check if all client has the same encoding:
            cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--background-index" },
            -- I'm going to use clangd on the remote server, but it's not working now.
            -- Remote lsp server and remote files, locally neovim toolkits.
            --
            -- 1. start clangd on the remote server. Done
            -- cmd = { "ssh", "localdocker.10510", "clangd", "--background-index", "--log=verbose", "--compile-commands-dir=/path/on/localdocker.10510" },
            -- 2. edit the files/directory on the remote server. TODO
        })
        vim.lsp.enable('clangd')

        -- ====== Python: pyright ======
        vim.lsp.config("pyright", {
            on_attach = common_attach,
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoImportCompletions = true,
                    },
                },
            },
        })
        vim.lsp.enable("pyright")

        vim.lsp.enable("thriftls")
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("bashls")
        vim.lsp.enable("ts_ls")
    end
}
