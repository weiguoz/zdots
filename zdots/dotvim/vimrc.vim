""" Events:
""" - 2005 created this file by Guanjun Zhang's helping

filetype off " 必须先关闭文件类型检查
" {{{ vim-plug, turn vundle/bundle to vim-plugin at 2019.11.18
call plug#begin('~/.vim/plugged')
" https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
Plug 'sainnhe/edge' " 'sainnhe/sonokai'
Plug 'liuchengxu/vista.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'MattesGroeger/vim-bookmarks'
" such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Plug 'skywind3000/asyncrun.vim'
Plug 'easymotion/vim-easymotion'
" {{{ git plugins
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
Plug 'rhysd/git-messenger.vim'
" :GitMessenger, nmap <Leader>gm <Plug>(git-messenger)
" }}}
Plug 'vim-scripts/FencView.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pechorin/any-jump.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'honza/vim-snippets' " coc-snippets works with vim-snippets
Plug 'christoomey/vim-tmux-navigator'
Plug 'github/copilot.vim'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library' " required by vim-mark
" {{{ 试用期
Plug 'mhinz/vim-startify'
Plug 'simnalamburt/vim-mundo'
Plug 'solarnz/thrift.vim'
Plug 'mattn/vim-goimports'
" Plug 'andymass/vim-matchup' 不需要
" }}}
call plug#end()
" }}}
filetype plugin indent on

call DirUndo()

" {{{ colorscheme
if Rand() % 4 == 0
    set background=dark
else
    set background=light
endif
colorscheme edge
" {{{ sonokai https://github.com/sainnhe/sonokai/blob/c4dfd15a2202eeeabefc13028af652c8322f2c49/doc/sonokai.txt#L118-L123
" let g:sonokai_style = 'maia'
" let g:sonokai_enable_italic = 1
" let g:sonokai_disable_italic_comment = 1
" colorscheme sonokai " Also, I like monokai-bold PaperColor herald 256-jungle palenight
" let g:airline_theme = "sonokai"
" }}}
" }}}

" general settings {{{
let mapleader = " "
let g:mapleader = " "
let maplocalleader = " "
let g:maplocalleader = " "
nnoremap <SPACE> <Nop>
" 让vim的补全行为与一般ide一致
" set completeopt=popup "https://github.com/neovim/neovim/issues/10996 support popup for version.vim >= 8.1.1880
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
set mouse-=r " disable mouse. or set mouse=a to enable mouse
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

" {{{ trailing whitespace, tail/end
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/
command! -range=% TrimWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" }}}

" {{{ shortcut, movements & jumps
nnoremap <silent> <c-u> :call MoveRatioOfWindow('up', 33)<CR>
nnoremap <silent> <c-d> :call MoveRatioOfWindow('down', 33)<CR>

" 在正常模式和插入模式快速跳到行首行尾
nnoremap <c-a> 0
nnoremap <c-e> $
" nnoremap <c-m> :call cursor(0, len(getline('.'))/2)<CR>
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
" inoremap jj <Esc>l
nmap zz :exec 'wq'<CR>
nmap <leader>w :exec 'w'<CR>
nmap <leader>q :exec 'q'<CR>
nmap <leader>o :only<CR>
"nmap <silent> <leader>k * ``
map <c-n> :tabnew<CR>

" quickfix ++
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
" Automatically fitting a quickfix window height
au FileType qf call AdjustWindowHeight(5, 13)
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
" movements in the insert mode
" conflict key with snippets expands, so i disable such keys
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
inoremap <c-w> <S-Right>
inoremap <c-b> <S-Left>
inoremap <c-o> <Esc>o
" buffer
nnoremap <silent>   <tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprev<CR>
""" movement }}}

" 保存一个本该 sudo 打开的文件
" cnoreabbrev w!! w !sudo tee >/dev/null %
" }}}

" {{{ Zoom/Restore window
" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>
" }}}

autocmd BufNewFile *.go,*.sh,*.py,*.c,*.cpp,*.h,*.hpp,*.hxx,*.hh exec ":call SetTitle()"
" autocmd BufWrite *.sh,*py if getline(6) != "# Modify Author: ".expand("$USER") || split(getline(7))[3] != strftime("%F") | call ModifyTitle() | endif
