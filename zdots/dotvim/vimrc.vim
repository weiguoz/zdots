""" Events:
""" - 2005 created this file by Guanjun Zhang's helping
call DirUndo()

" {{{ UI
if Rand() % 100 < 50
    set background=dark
else
    set background=light
endif
nnoremap <silent> <c-g> :call ToggleBackground()<CR>
colorscheme edge
" set pumblend=0 " neovim: transparent, also winblend
" {{{ sonokai https://github.com/sainnhe/sonokai/blob/c4dfd15a2202eeeabefc13028af652c8322f2c49/doc/sonokai.txt#L118-L123
" let g:sonokai_style = 'maia'
" let g:sonokai_enable_italic = 1
" let g:sonokai_disable_italic_comment = 1
" colorscheme sonokai " Also, I like monokai-bold PaperColor herald 256-jungle palenight
" let g:airline_theme = "sonokai"
" }}}
" }}}

" general settings {{{
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
set encoding=utf-8 fileencodings=utf-8,ucs-bom,cp936,gbk,gb2312,gb18030 " 编码控制 http://liwuzhi.art/?p=541

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
inoremap jk <Esc>l
inoremap kj <Esc>l
nmap zz :exec 'q'<CR>
nmap <c-s> :exec 'w'<CR>
inoremap <c-s> <esc>:w<CR>
" nmap <c-q> :exec 'q'<CR>
" nmap <silent> <leader>k * ``
" map <c-n> :tabNext<CR>  gt gT for tabnext is good enough, but tab is not good for me

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
au FileType qf call AdjustWindowHeight(5, 13) " Automatically fitting a quickfix window height

""" {{{ movement
" movements in the insert mode
" conflict key with snippets expands, so I disable such keys
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
inoremap <c-w> <S-Right>
inoremap <c-b> <S-Left>
inoremap <c-o> <Esc>o
" buffer
nmap b[ :bp<CR>
nmap b] :bn<CR>
nnoremap <silent>   <tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprev<CR>
""" movement }}}

" 保存一个本该 sudo 打开的文件
" cnoreabbrev w!! w !sudo tee >/dev/null %
" }}}

nnoremap <silent> <leader>z :call ZoomToggle()<CR>

autocmd BufNewFile *.go,*.sh,*.py,*.c,*.cpp,*.h,*.hpp,*.hxx,*.hh exec ":call SetTitle()"
" autocmd BufWrite *.sh,*py if getline(6) != "# Modify Author: ".expand("$USER") || split(getline(7))[3] != strftime("%F") | call ModifyTitle() | endif
