""" Author: weiguoz@GitHub
""" Events:
""" - 2005 created this file by Guanjun Zhang's helping

filetype off " 必须先关闭文件类型检查
" {{{ vim-plug, turn vundle/bundle to vim-plugin at 2019.11.18
call plug#begin('~/.vim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'liuchengxu/vista.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'
Plug 'dstein64/vim-win'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'MattesGroeger/vim-bookmarks'
" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Plug 'skywind3000/asyncrun.vim'
Plug 'easymotion/vim-easymotion'
" {{{ git plugins
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
" :GitMessenger, nmap <Leader>gm <Plug>(git-messenger)
" }}}
Plug 'vim-scripts/FencView.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'
Plug 'mhinz/vim-startify'
Plug 'pechorin/any-jump.vim'
" {{{ 试用期
Plug 'simnalamburt/vim-mundo'
Plug 'francoiscabrol/ranger.vim'
" }}}
call plug#end()
" }}}
filetype plugin indent on

call DirUndo()

" general settings {{{
let mapleader = " "
let g:mapleader = " "
let maplocalleader = " "
let g:maplocalleader = " "
nnoremap <SPACE> <Nop>
" 让vim的补全行为与一般ide一致
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
set cursorline " set cursorcolumn
set backspace=indent,eol,start
" indent
set smarttab
set smartindent
set ts=4 sw=4 ai et

set nu
set mouse-=r " enable mouse, or mouse-=a
set linebreak " 不在单词中间折行
set foldmethod=marker " marker 这个容易操控. /indent 根据缩进自动折行。zm zr来增减折行层次,za打开关闭
set encoding=utf-8 fileencodings=utf-8,gbk,gb2312,gb18030 termencoding=utf-8 " 编码控制

set ignorecase
set smartcase
set incsearch
set hlsearch
set nolazyredraw " Don't redraw while executing macros
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

" {{{ trailing whitespace, tail/end
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/
command! -range=% TrimWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" }}}

" {{{ shortcut, movements & jumps
nnoremap <silent> <c-k> :call MoveRatioOfWindow('up', 33)<CR>
nnoremap <silent> <c-j> :call MoveRatioOfWindow('down', 33)<CR>

imap <c-w> <ESC> :call Write('stay')<CR>l
omap <c-w> <ESC> :call Write('stay')<CR>l
nmap <c-w> :call Write('stay')<CR>
nmap zz :call Write('quit')<CR>
nmap <leader>o :only<CR>
nmap <leader>/ *
map  <c-n> :tabnew<CR>

" quickfix ++
nmap <leader>q :cclose<CR>
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

""" {{{ movement
" nmap <silent>ge :call cursor(0, len(getline('.'))/2)<CR>
nmap ge $

" movements in the insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-w> <S-Right>
inoremap <C-b> <S-Left>
" buffer
" nnoremap <silent>   <tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
" nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprev<CR>
""" movement }}}

" 保存一个本该 sudo 打开的文件
cnoreabbrev w!! w !sudo tee >/dev/null %
" }}}

autocmd BufNewFile *.sh,*.py,*.c,*.cpp,*.h,*.hpp,*.hxx,*.hh exec ":call SetTitle()"
" autocmd BufWrite *.sh,*py if getline(6) != "# Modify Author: ".expand("$USER") || split(getline(7))[3] != strftime("%F") | call ModifyTitle() | endif
" Expose functions defined in lib.vim
au FileType cpp,c command! -nargs=0 Crun :call CompileCxxAndRun()
au FileType * command! -nargs=0 Cleanemptybuffers :call CleanEmptyBuffers()
