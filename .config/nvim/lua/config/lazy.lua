-- plugins saved in ~/.local/share/nvim/lazy
return require('lazy').setup(
  {
    { import = 'plugins.colorscheme' },

    { import = 'plugins.telescope' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.noice' },
    { import = 'plugins.statusbar' },

    { import = 'plugins.cmp' },
    { import = 'plugins.lsp' },
    { import = 'plugins.dap' },
    { import = 'plugins.copilot' }, -- ai
    { import = 'plugins.tree' },
    { import = 'plugins.luasnip' },

    --' such as: AsyncRun tmux send-keys -t2 \'go test\' enter
    { import = 'plugins.asyncrun' }, -- integrates f-person/git-blame.nvim and mhinz/vim-signify

    -- git plugins
    { 'tpope/vim-fugitive' },
    { import = 'plugins.gitsigns' }, -- integrates f-person/git-blame.nvim and mhinz/vim-signify

    { import = 'plugins.highlighter' },
    { import = 'plugins.bookmarks' },
    { 'tpope/vim-commentary' },
    { 'vim-scripts/FencView.vim' },
    -- { 'christoomey/vim-tmux-navigator' },
    { 'simnalamburt/vim-mundo' },

    -- {{{ observing
    -- Plug 'easymotion/vim-easymotion' search paste is broken so I disable it
    { import = 'plugins.sneak' },
    { import = 'plugins.whichkey' },
    { 'mhinz/vim-startify' },
    { 'solarnz/thrift.vim' },
    { 'mattn/vim-goimports' },
    -- intelligently reopens files at your last edit position
    { 'farmergreg/vim-lastplace' },
    { import = 'plugins.filebrowser' },
    { 'LintaoAmons/cd-project.nvim' }, -- db = ~/.config/nvim/cd-project.nvim.json
    { import = 'plugins.autopairs' },
    -- { 'francoiscabrol/ranger.vim' },
    -- }}}
  },
  { checker = { enabled = true, frequency = 86400 } }
)
