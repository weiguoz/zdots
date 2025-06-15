-- plugins saved in ~/.local/share/nvim/lazy
return require('lazy').setup(
    {
        { import = 'plugins.colorscheme' },

        { import = 'plugins.telescope' },
        { import = 'plugins.treesitter' },
        { import = 'plugins.noice-cmd' },
        { import = 'plugins.statusbar' },
        { import = 'plugins.cursor' },
        { import = 'plugins.whichkey' },
        { import = 'plugins.dropbar' },

        { import = 'plugins.cmp' },
        { import = 'plugins.lsp' },
        { import = 'plugins.dap' },
        { import = 'plugins.copilot' }, -- ai
        { import = 'plugins.filemanager' },
        { import = 'plugins.luasnip' },

        -- such as: AsyncRun tmux send-keys -t2 \'go test\' enter
        { import = 'plugins.asyncrun' },

        -- git plugins
        { 'tpope/vim-fugitive' },
        { import = 'plugins.gitsigns' },

        { import = 'plugins.highlighter' },
        { import = 'plugins.bookmarks' },
        { 'tpope/vim-commentary' },
        { 'vim-scripts/FencView.vim' },
        { 'christoomey/vim-tmux-navigator' },
        { 'simnalamburt/vim-mundo' },

        { import = 'plugins.sider' },
        { import = 'plugins.autopairs' },
        { 'farmergreg/vim-lastplace' }, -- intelligently reopens files at your last edit position
        { import = 'plugins.indentscope' },
        { 'mattn/vim-goimports' },

        -- observing
        -- db = ~/.config/nvim/cd-project.nvim.json
        -- { "HiPhish/rainbow-delimiters.nvim" }, -- when i run lazy update, it spends a lot of time on this plugin(submodule like test/*)
        { 'mhinz/vim-startify' },
        { import = 'plugins.mini-nvim' }, -- icons
    }, {
        checker = { enabled = true, frequency = 10 * 86400 },
    }
)
