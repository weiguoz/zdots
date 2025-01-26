-- plugins saved in ~/.local/share/nvim/lazy
return require("lazy").setup(
  {
    -- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
    -- colorschema " 'sainnhe/sonokai', 'sainnhe/edge', 'sainnhe/everforest'
    { 'sainnhe/edge' },

    { import = "plugins.telescope" },
    { import = 'plugins.treesitter' },
    { import = 'plugins.noice' },
    { 'vim-airline/vim-airline' },
    { 'airblade/vim-rooter' },

    -- { "junegunn/fzf", build = "./install --all" },
    { "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },

    { import = "plugins.nvim-cmp" },
    { import = "plugins.nvim-lspconfig" },
    { import = "plugins.copilot" }, -- ai
    { import = "plugins.tree" },
    { import = "plugins.luasnip" },

    --" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
    { 'skywind3000/asyncrun.vim' },

    -- git plugins
    { 'tpope/vim-fugitive' },
    { import = "plugins.gitsigns" }, -- integrates f-person/git-blame.nvim and mhinz/vim-signify

    { import = "plugins.bookmarks" },
    { 'tpope/vim-commentary' },
    { 'vim-scripts/FencView.vim' },
    { 'christoomey/vim-tmux-navigator' },
    { import = "plugins.vim-mark" },
    { 'simnalamburt/vim-mundo' },

    -- {{{ observing
    -- Plug 'easymotion/vim-easymotion' search paste is broken so I disable it
    { import = "plugins.vim-sneak" },
    -- { 'justinmk/vim-sneak' },
    { 'mhinz/vim-startify' },
    { 'solarnz/thrift.vim' },
    { 'mattn/vim-goimports' },
    -- intelligently reopens files at your last edit position
    { 'farmergreg/vim-lastplace' },
    { import = 'plugins.file-browser' },
    { 'LintaoAmons/cd-project.nvim' }, -- db = ~/.config/nvim/cd-project.nvim.json
    { import = 'plugins.autopairs' },
    -- { 'pechorin/any-jump.vim' },
    -- { 'francoiscabrol/ranger.vim' },
    -- }}}
  },
  { checker = { enabled = true, frequency = 86400 } }
)
