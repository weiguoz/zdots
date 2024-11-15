-- saved in ~/.local/share/nvim/lazy

return require("lazy").setup({
  --  https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme

  -- colorschema " 'sainnhe/sonokai' 'sainnhe/edge'
  { 'sainnhe/edge' },

  -- " for gopher: Fast, 'tree-sitter'-like Vim Syntax Highlighting for Go
  { 'charlespascoe/vim-go-syntax' },

  -- "  曾经：它依赖的 ctags 不能支持 go: [vista.vim] ctags: Warning: Unsupported kind: 'w' for --go-kinds option
  { 'liuchengxu/vista.vim' },

  { 'vim-airline/vim-airline' },
  { 'airblade/vim-rooter' },

  -- fzf
  { 'junegunn/fzf',
      build = function()
        vim.fn['fzf#install']()
      end,
  },
  { 'junegunn/fzf.vim' },

  { 'neoclide/coc.nvim', branch = 'release', build = 'npm ci' },
  { 'antoinemadec/coc-fzf', branch = 'release' }, -- https://github.com/neoclide/coc.nvim/issues/1586#issuecomment-591856683

  --" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
  { 'skywind3000/asyncrun.vim' },

  -- {{{ git plugins
  { 'mhinz/vim-signify' },
  { 'tpope/vim-fugitive' },
  { 'APZelos/blamer.nvim' },
  -- :GitMessenger, nmap <leader>gm <Plug>(git-messenger)
  { 'rhysd/git-messenger.vim' },
  -- }}}

  { 'tpope/vim-commentary' },
  { 'vim-scripts/FencView.vim' },
  { 'pechorin/any-jump.vim' },
  { 'francoiscabrol/ranger.vim' },
  -- coc-snippets works with vim-snippets
  { 'honza/vim-snippets' },
  { 'christoomey/vim-tmux-navigator' },
  { 'github/copilot.vim' },
  { 'inkarkat/vim-mark',
    dependencies = {
      { 'inkarkat/vim-ingo-library'}
    }
  },
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

  { import = "plugins.bookmarks" },
})
