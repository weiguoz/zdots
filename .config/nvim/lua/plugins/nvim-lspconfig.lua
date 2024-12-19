return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local telescope = require('telescope.builtin')

    -- common attach function
    local common_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }

        -- lsp
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', 'rc', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true, silent = true })
        -- vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { noremap = true, silent = true })
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        -- https://github.com/lopi-py/nvim-config/blob/a9c2c73dbea6472adb068eb2cd9a8810322d973a/lua/lsp.lua#L23
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", bufopts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)
        vim.keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<cr>", bufopts)

        -- diagnostic
        vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>di', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>dl', function()
          require('telescope.builtin').diagnostics({ severity_sort = true }) -- sort by severity
        end, opts)
        -- add agnostic to loclist then export to telescope is a good idea, but the loclist popup is not good
        -- vim.keymap.set('n', '<leader>dl', function()
        --   vim.diagnostic.setloclist() -- add diagnostic to loclist
        --   telescope.loclist() -- open loclist with telescope
        -- end, opts)
    end

    lspconfig.gopls.setup({
      on_attach = common_attach,
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_dir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
      settings = {
        gopls = {
          analyses = {
            unreachable_code = true,
            unused_params = true,
          },
          staticcheck = true,
        },
      },
    })

    lspconfig.clangd.setup({
      on_attach = common_attach,
      cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--background-index" },
    })

    lspconfig.bashls.setup({
      on_attach = common_attach,
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh", "bash" },
      root_dir = require('lspconfig').util.root_pattern(".git", ".bashrc", ".bash_profile"),
      settings = {
        bash = {
            diagnostics = { enable = true },
        },
      },
    })

    lspconfig.thriftls.setup({
      on_attach = common_attach,
      -- cmd = { "thriftls" }, build thriftls from source
      -- git clone https://github.com/joyme123/thrift-ls && go build -o $GOPATH/bin/thriftls
    })

  end
}
