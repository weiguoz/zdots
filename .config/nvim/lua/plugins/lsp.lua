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

        -- common attach function
        local common_attach = function(_, bufnr)
            local opts = { noremap=true, silent=true, buffer=bufnr }

            -- lsp
            --- how telescope >
            --- https://github.com/lopi-py/nvim-config/blob/a9c2c73dbea6472adb068eb2cd9a8810322d973a/lua/lsp.lua#L23
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, merge_table(opts, { desc = "LSP: definition" }))
            vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", merge_table(opts, { desc = "LSP: type definition" }))

            vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, merge_table(opts, { desc = "LSP: rename" }))
            vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, merge_table(opts, { desc = "LSP: code action" }))
            vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", merge_table(opts, { desc = "LSP: implementations" }))
            vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", merge_table(opts, { desc = "LSP: references" }))

            -- diagnostic
            vim.keymap.set('n', 'e', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', 'E', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>gf', vim.diagnostic.open_float, merge_table(opts, { desc = "Diagnostic: information" })) -- need buffer=bufnr?
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
        end

        -- lsp: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
 
        -- 当在某个 go 项目根目录(含 go.mod)，编辑时可正常判断项目所在目录，即搜索显示的目录都正常，搜索结果不包含 /path/to/project
        -- 然而，当在子文件夹用 nvim 打开文件时，则无法判断所在的项目目录，即搜索显示 /path/to/project/**
        -- 我希望通过 lsp 来实现 cd-project 这类插件的效果
        -- 注意到：
        --   1. 执行 echo getcwd() 显示不在根目录
        --   2. 执行 LspInfo 显示Root directory 正确
        -- 只要将 Lsp 分析的结果设置为当前目录即可
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local root_dir = client and client.config and client.config.root_dir
            if root_dir and vim.api.nvim_buf_is_loaded(args.buf) then
              vim.cmd("lcd " .. root_dir)
            end
          end,
        })

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
        lsp.clangd.setup({
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
        lsp.bashls.setup({
            on_attach = common_attach,
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            root_dir = require('lspconfig').util.root_pattern(".git", ".bashrc", ".bash_profile"),
            settings = { bash = { diagnostics = { enable = true }}},
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
        lsp.lua_ls.setup({ on_attach = common_attach,
            settings = { Lua = { diagnostics = { globals = { 'vim' }}}},
        })
        -- ts
        lsp.ts_ls.setup({ on_attach = common_attach })
    end
}
