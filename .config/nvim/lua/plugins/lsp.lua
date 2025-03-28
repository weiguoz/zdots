return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        -- local telescope = require('telescope.builtin')

        -- common attach function
        local common_attach = function(_, bufnr)
            local opts = { noremap=true, silent=true, buffer=bufnr }

            -- lsp
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            -- how telescope >
            -- https://github.com/lopi-py/nvim-config/blob/a9c2c73dbea6472adb068eb2cd9a8810322d973a/lua/lsp.lua#L23
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

            -- diagnostic
            vim.keymap.set('n', 'e', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', 'E', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>ei', vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Diagnostic: information" }) -- need buffer=bufnr?
            vim.keymap.set('n', '<leader>el', "<cmd>Telescope diagnostics<cr>", {noremap = true, silent = true, buffer=bufnr, desc = "Diagnostic: list"})
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
        end

        -- lsp: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

        -- golang
        lspconfig.gopls.setup({
            on_attach = common_attach,
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_dir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
            settings = {
                gopls = {
                    analyses = { unreachable_code = true, unused_params = true, },
                    staticcheck = true,
                },
            }
        })
        -- c/c++
        lspconfig.clangd.setup({
            on_attach = common_attach,
            cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--background-index" },
            -- I'm going to use clangd on the remote server, but it's not working now.
            -- Remote lsp server and remote files, locally neovim toolkits.
            --
            -- 1. start clangd on the remote server. Done
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- capabilities.offsetEncoding = { "utf-16" }
            -- capabilities = capabilities,
            -- cmd = { "ssh", "localdocker.10510", "clangd", "--background-index", "--log=verbose", "--compile-commands-dir=/path/on/localdocker.10510" }, 
            -- 2. edit the files/directory on the remote server. TODO
        })
        -- bash
        lspconfig.bashls.setup({
            on_attach = common_attach,
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            root_dir = require('lspconfig').util.root_pattern(".git", ".bashrc", ".bash_profile"),
            settings = {
                bash = { diagnostics = { enable = true }, },
            },
        })
        -- thrift
        -- cmd = { "thriftls" }, build thriftls from source
        -- git clone https://github.com/joyme123/thrift-ls && go build -o $GOPATH/bin/thriftls
        lspconfig.thriftls.setup({ on_attach = common_attach })
        -- sql
        -- go install github.com/sqls-server/sqls@latest
        lspconfig.sqls.setup({ on_attach = common_attach })
        -- jsonnet
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonnet_ls
        lspconfig.jsonnet_ls.setup({ on_attach = common_attach })
        -- rust
        lspconfig.rust_analyzer.setup({ on_attach = common_attach })
        -- python
        lspconfig.pyright.setup({ on_attach = common_attach })
        -- lua
        lspconfig.lua_ls.setup({
            on_attach = common_attach,
            settings = {
                Lua = { diagnostics = { globals = { 'vim' } }, },
            },
        })
        -- ts
        lspconfig.ts_ls.setup({ on_attach = common_attach })
    end
}
