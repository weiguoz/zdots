""" Author: w e i g u o z@github
""" Events:
""" - 2005 created this file by Guanjun Zhang's helping

filetype off                   " 必须先关闭文件类型检查
" {{{ vim-plug, turn vundle/bundle to vim-plugin at 2019.11.18
call plug#begin('~/.vim/plugged')
Plug 'NLKNguyen/papercolor-theme'
" replaced by https://github.com/weirongxu/coc-explorer
" Plug 'preservim/nerdtree'
" replaced by vista.vim
" Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim'
" statusbar
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'
Plug 't9md/vim-choosewin'
" 1. kien/ctrlp.vim & vim-scripts/mru.vim --> replaced by LeaderF by Yggdroot@newsmth
" 2. LeaderF replaced by fzf : Files
" Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
" Plug 'wsdjeg/FlyGrep.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'dense-analysis/ale' replaced by coc
Plug 'lfv89/vim-interestingwords'
" https://github.com/MattesGroeger/vim-bookmarks#usage
Plug 'MattesGroeger/vim-bookmarks'
" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Plug 'skywind3000/asyncrun.vim'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go'
" {{{ git plugins
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
" :GitMessenger, nmap <Leader>gm <Plug>(git-messenger)
" }}}
Plug 'vim-scripts/FencView.vim'
" 单一的大杀器 youcompleteme 问题太多了:
" 1）更新升级之后经常出现不能自动补全
" 2）需重新编译
" 3）submodules 常无法下载
" vim 里遇到的问题，80% 都来自 YCM，所以在 202157 转投支持 lsp 的 coc
" Plug 'ycm-core/YouCompleteMe', {'do': 'python3 install.py --clangd-completer --go-completer'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'
Plug 'mhinz/vim-startify'
Plug 'pechorin/any-jump.vim'
" install the fonts{mac: brew tap homebrew/cask-fonts && brew cask install font-hack-nerd-font }
" Plug 'ryanoasis/vim-devicons' this plugin helps nerdtree, but we don't need
" nerdtree anymore.
" {{{ 试用期
" A git blame plugin for (neo)vim inspired by VS Code's GitLens plugin
" blamer.nvim is not passed. incompatible with 'tpope/vim-fugitive' & 'rhysd/git-messenger.vim'
" Plug 'APZelos/blamer.nvim'  again, LBTM. 2021/2/21
" Plug 'bagrat/vim-buffet'
Plug 'simnalamburt/vim-mundo'
" Plug 'thaerkh/vim-workspace' " not passed. sth. bad to GoReferrers
" }}}
call plug#end()
" }}}
filetype plugin indent on

" brings vim-mundo back
call DirUndo()

" general settings {{{
let mapleader = " " " Leader is the space key
let g:mapleader = " "
let maplocalleader = "`"
let g:maplocalleader = "`"
nnoremap <SPACE> <Nop>
" 自动补全
" 让vim的补全菜单行为与一般ide一致
set completeopt=popup "https://github.com/neovim/neovim/issues/10996 support popup for version.vim >= 8.1.1880
" set completeopt=longest,menu
set autochdir
au BufWrite /private/etc/pw.* set nowritebackup nobackup " Don't write backup file if vim is being called by "chpass"
syntax enable
set t_Co=256
set ruler
set showcmd
set showmatch
set showmode
au filetype c,cpp,go,python set cc=81
" au BufNewFile,BufRead *.vm,*.html,*.htm,*.shtml,*.stm set ft=velocity
set cursorline " set cursorcolumn
set backspace=indent,eol,start
" set formatoptions-=croq " don't continue comments when pushing o/O
""""""""""""缩进""""""""""""
set smarttab
set smartindent
set ts=4 sw=4 ai et
set nu
set mouse-=r           " enable mouse, or mouse-=a
set linebreak          " 不在单词中间折行
set foldmethod=marker  " marker 这个容易操控. /indent 根据缩进自动折行。zm zr来增减折行层次,za打开关闭
" set ffs=unix,dos,mac
set encoding=utf-8 fileencodings=utf-8,gbk,gb2312,gb18030 termencoding=utf-8 " 编码控制
" set guifont=Monaco:h9 Monaco:h10 Courier_New:h11:cANSI 指定字体

call CleanWin32Toolbar()

set ignorecase   " Ignore case when searching
set smartcase
set incsearch
set hlsearch
set nolazyredraw " Don't redraw while executing macros
" set verbose=9	" turn this ON when we want to debug
set wildmenu
set wildmode=longest,full " list
set wildignore=*.o,*.obj,*~
" }}}

" {{{ colorscheme
let g:palenight_terminal_italics=1
set background=dark
colorscheme PaperColor " Also, I like monokai-bold PaperColor herald 256-jungle palenight
" let g:airline_theme = "palenight"
" }}}

"{{{ golang
" vim-go 默认使用 guru 做跳转，太慢了. 根据
" https://github.com/fatih/vim-go/issues/887#issuecomment-224107754
" 中途我换过 godef,  在2019 年 10 月开始换成 gopls
let g:go_def_mode = 'gopls'

"" https://github.com/golang/lint
" set rtp+=/path/to/go/src/golang.org/x/lint/misc/vim
" invoke gofmt without plugin using `au BufWritePost *.go silent !gofmt -w %`
" then `set autoread` to reload buffer
let g:go_fmt_autosave=1
let g:go_fmt_command = "goimports"
" autocmd BufWritePost,FileWritePost *.go silent execute 'GoMetaLinter' | cwindow

" GoMetaLinter invoke all possible linters (golint, vet, errcheck, deadcode, etc.) and put
" the result in the quickfix or location list.
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap gr :GoReferrers<CR>
au FileType go nmap ds :GoDefStack<CR>
au FileType go nmap gv <Plug>(go-def-vertical)
au FileType go nmap <leader>T <Plug>(go-test)
" }}}

" {{{ trailing whitespace, tail/end
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/
command! -range=% TrimWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" }}}

" {{{ shortcut, movements & jumps
nnoremap <silent> <c-k> :call MoveRatioOfWindow('up', 33)<CR>
nnoremap <silent> <c-j> :call MoveRatioOfWindow('down', 33)<CR>
" nmap <Leader>j :call GotoJump()<CR>

imap <c-c> <ESC> :w<CR>l
omap <c-c> <ESC> :w<CR>l
nnoremap <leader>w :call Write()<CR>
nmap <Leader>o :only<CR>
nmap <c-c> :ChooseWin<CR>

" map paste, yank and delete
" set viminfo='20,<1000  " allow copying of more than 50 lines to other applications
" nnoremap x "_x
" vnoremap x "_x
" set clipboard=unnamed

" nmap <Leader>l :ALEToggle<CR>
nmap <leader>a :AsyncRun<space>
" fzf quicks +++
" https://stackoverflow.com/a/32047331/479812
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
map <leader>/ :Rg 
" fzf quicks ---
" quickfix ++
nmap <leader>c :cclose<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
" Automatically fitting a quickfix window height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
" quickfix --

""" {{{ movement
" nmap <silent>ge :call cursor(0, len(getline('.'))/2)<CR>
nmap ge $

" nmap E <Plug>(ale_previous_wrap)
" nmap e <Plug>(ale_next_wrap)
" movements in the insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" a word
inoremap <C-w> <S-Right>
inoremap <C-b> <S-Left>
" buffer
" nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
" nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprev<CR>
""" movement }}}

" 保存一个本该 sudo 打开的文件
" cnoremap
cnoreabbrev w!! w !sudo tee >/dev/null %
" }}}

" Expose functions defined in lib.vim
au FileType cpp,c command! -nargs=0 Crun :call CompileCxxAndRun()
au FileType cpp,c,python command! -nargs=0 Adddesc :call AddDesc()
au FileType * command! -nargs=0 Cleanemptybuffers :call CleanEmptyBuffers()
