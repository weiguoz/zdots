-- plugins saved in ~/.local/share/nvim/lazy
return require('lazy').setup(
  {
    { import = 'plugins.colorscheme' },

    { import = 'plugins.treesitter' },
    { import = 'plugins.noice' },
    { import = 'plugins.statusbar' },
    { import = 'plugins.cursor' },
    { import = 'plugins.whichkey' },
    { import = 'plugins.telescope' },

    { import = 'plugins.cmp' },
    { import = 'plugins.lsp' },
    { import = 'plugins.dap' },
    { import = 'plugins.copilot' }, -- ai
    { import = 'plugins.filemanager' },
    { import = 'plugins.luasnip' },

    --' such as: AsyncRun tmux send-keys -t2 \'go test\' enter
    { import = 'plugins.asyncrun' },

    -- git plugins
    { 'tpope/vim-fugitive' },
    { import = 'plugins.gitsigns' },

    { import = 'plugins.highlighter' },
    { import = 'plugins.bookmarks' },
    { 'tpope/vim-commentary' },
    { 'vim-scripts/FencView.vim' },
    -- { 'christoomey/vim-tmux-navigator' },
    { 'simnalamburt/vim-mundo' },

    -- {{{ observing
    { import = 'plugins.sneak' }, -- 'easymotion/vim-easymotion' search paste is broken so I disable it
    { import = 'plugins.autopairs' },
    { 'mhinz/vim-startify' },
    { 'solarnz/thrift.vim' },
    { 'mattn/vim-goimports' },
    { 'farmergreg/vim-lastplace' }, -- intelligently reopens files at your last edit position
    { 'LintaoAmons/cd-project.nvim' }, -- db = ~/.config/nvim/cd-project.nvim.json
    -- }}}
  },
  { checker = { enabled = true, frequency = 10*86400 } } -- x*day
)
