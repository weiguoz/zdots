-- plugins saved in ~/.local/share/nvim/lazy
return require("lazy").setup(
  {
    -- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
    -- colorschema " 'sainnhe/sonokai'
    { 'sainnhe/edge' },

    { 'charlespascoe/vim-go-syntax' }, -- " for gopher: Fast, 'tree-sitter'-like Vim Syntax Highlighting for Go

    -- 曾经：它依赖的 ctags 不能支持 go: [vista.vim] ctags: Warning: Unsupported kind: 'w' for --go-kinds option
    -- { 'liuchengxu/vista.vim' },

    { 'vim-airline/vim-airline' },
    { 'airblade/vim-rooter' },

    -- fzf
    { "junegunn/fzf", build = "./install --all" },
    { "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },

    -- telescope
    { import = "plugins.telescope" },

    { import = "plugins.nvim-tree" },
    { import = "plugins.nvim-lspconfig" },
    { import = "plugins.nvim-cmp" },

    --" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
    { 'skywind3000/asyncrun.vim' },

    -- git plugins
    { 'tpope/vim-fugitive' },
    { import = "plugins.gitsigns" }, -- integrates f-person/git-blame.nvim and mhinz/vim-signify
    { import = "plugins.git-messenger" },

    { import = "plugins.bookmarks" },
    { 'tpope/vim-commentary' },
    { 'vim-scripts/FencView.vim' },
    { 'pechorin/any-jump.vim' },
    { 'francoiscabrol/ranger.vim' },
    { 'christoomey/vim-tmux-navigator' },
    { 'github/copilot.vim' },
    { 'weiguoz/vim-mark', dependencies = { 'inkarkat/vim-ingo-library' } },
    { 'simnalamburt/vim-mundo' },

    -- {{{ observing
    -- Plug 'easymotion/vim-easymotion' search paste is broken so I disable it
    { 'justinmk/vim-sneak' },
    { 'mhinz/vim-startify' },
    { 'solarnz/thrift.vim' },
    { 'mattn/vim-goimports' },
    -- intelligently reopens files at your last edit position
    { 'farmergreg/vim-lastplace' },
    -- }}}
  },
  { checker = { enabled = true, frequency = 86400 } }
)
