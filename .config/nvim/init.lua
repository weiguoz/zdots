vim.cmd [[
call plug#begin('~/.vim/plugged')
" https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
Plug 'sainnhe/edge' " 'sainnhe/sonokai' 'sainnhe/edge'
Plug 'charlespascoe/vim-go-syntax' " for gopher: Fast, 'tree-sitter'-like Vim Syntax Highlighting for Go
Plug 'liuchengxu/vista.vim' "  曾经：它依赖的 ctags 不能支持 go: [vista.vim] ctags: Warning: Unsupported kind: 'w' for --go-kinds option
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" telescope (only for nvim)
Plug 'nvim-telescope/telescope.nvim' " needs plenty.nvim
Plug 'nvim-lua/plenary.nvim'
" 'MattesGroeger/vim-bookmarks' was replaced by 'LintaoAmons/bookmarks.nvim'
Plug 'LintaoAmons/bookmarks.nvim' " needs telescope.nvim

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'} " https://github.com/neoclide/coc.nvim/issues/1586#issuecomment-591856683
" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Plug 'skywind3000/asyncrun.vim'
" {{{ git plugins
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
Plug 'rhysd/git-messenger.vim' " :GitMessenger, nmap <leader>gm <Plug>(git-messenger)
" }}}
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/FencView.vim'
Plug 'pechorin/any-jump.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'honza/vim-snippets' " coc-snippets works with vim-snippets
Plug 'christoomey/vim-tmux-navigator'
Plug 'github/copilot.vim'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library' " required by vim-mark
Plug 'simnalamburt/vim-mundo'
" {{{ observing
" Plug 'easymotion/vim-easymotion' search paste is broken so I disable it
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'solarnz/thrift.vim'
Plug 'mattn/vim-goimports'
Plug 'farmergreg/vim-lastplace' " intelligently reopens files at your last edit position
" }}}
call plug#end()
]]


local init_vims = { "functions.vim", "vimrc.vim", "plugin_settings.vim" }
-- 使用 for 循环打印每个字符串
for _, f in ipairs(init_vims) do
    local init_vim_path = string.format("%s/zdots/dotvim/%s", os.getenv("HOME"), f)
    if vim.fn.filereadable(init_vim_path) then
        vim.cmd('source ' .. init_vim_path)
    end
end
