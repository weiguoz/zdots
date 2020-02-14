""" Author: weiguoz@github
""" Events:
""" - 2005 created this file by Guanjun Zhang's helping

filetype off                   " 必须先关闭文件类型检查
" {{{ vim-plug, turn vundle/bundle to vim-plugin at 2019.11.18
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline' " statusbar
Plug 't9md/vim-choosewin'
Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'dense-analysis/ale'
Plug 'lfv89/vim-interestingwords'
" https://github.com/MattesGroeger/vim-bookmarks#usage
Plug 'MattesGroeger/vim-bookmarks'
Plug 'SirVer/ultisnips'
Plug 'skywind3000/asyncrun.vim' "such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'} " kien/ctrlp.vim & vim-scripts/mru.vim --> replaced by LeaderF by Yggdroot@newsmth
Plug 'fatih/vim-go'
" {{{ git plugins
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim' " :GitMessenger, nmap <Leader>gm <Plug>(git-messenger)
" }}}
Plug 'vim-scripts/FencView.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --system-libclang --clang-completer --go-completer'}
call plug#end()
" }}}
filetype plugin indent on

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
set linebreak	       " 不在单词中间折行
set foldmethod=marker  " marker 这个容易操控. /indent 根据缩进自动折行。zm zr来增减折行层次,za打开关闭
" set ffs=unix,dos,mac
" set encoding=utf-8
set encoding=utf-8 fileencodings=utf-8,gbk,gb2312,gb18030 termencoding=utf-8 " 编码控制
" set guifont=Monaco:h9 Monaco:h10 Courier_New:h11:cANSI 指定字体

call DirUndo()
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

colorscheme molokai " monokai-bold PaperColor herald 256-jungle
" autocmd BufNewFile,BufRead *.go colorscheme PaperColor
" let g:airline_theme='molokai'
set background=dark

"{{{ python
" let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
" " https://github.com/vim/vim/issues/3117 解决启动时因为python3的报警
" if has('python3')
"     silent! python3 1
" endif
" let g:ycm_server_python_interpreter
let g:pymode_rope = 0
"}}}

"{{{ golang
" vim-go 默认使用 guru 做跳转，太慢了. 根据
" https://github.com/fatih/vim-go/issues/887#issuecomment-224107754
" 中途我换过 godef,  在2019 年 10 月开始换成 gopls
let g:go_def_mode = 'gopls'

"" https://github.com/golang/lint
" set rtp+=/User/weiguo/go/src/golang.org/x/lint/misc/vim
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
au FileType go nmap gv <Plug>(go-def-vertical)
au FileType go nmap ds :GoDefStack<CR>
au FileType go nmap <Leader>d <Plug>(go-def-tab)
au FileType go nmap <leader>T <Plug>(go-test)
" }}}

" {{{ trailing whitespace
match Error /\s\+$/
" another better implementation is: command! -range=% FixWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
function! s:FixWhitespace(line1,line2)
    let l:save_cursor=getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction
" }}}

" {{{ shortcut, movements & jumps
au FileType cpp,c,python command! -nargs=0 Adddesc :call AddDesc() " 源码说明头
nnoremap <silent> <c-k> :call MoveRatioOfWindow('up', 40)<CR>
nnoremap <silent> <c-j> :call MoveRatioOfWindow('down', 40)<CR>
nmap <Leader>j :call GotoJump()<CR>
nmap <c-c> :ChooseWin<CR>

" mapping ESC
inoremap <c-c> <ESC> :w<CR>
" imap ww <Esc> :w<CR>
nmap qa :wqa<CR>
nmap q: :q<CR>
nmap <Leader>w :w!<CR>

" map paste, yank and delete
set viminfo='20,<1000  " allow copying of more than 50 lines to other applications
nnoremap x "_x
vnoremap x "_x
set clipboard=unnamed

nmap <Leader>o :on<CR>
nmap <Leader>l :ALEToggle<CR>
nmap <leader>h :MundoToggle<CR>
nmap <leader>a :AsyncRun<space>
" quickfix ++
nmap <leader>c :cclose<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
" quickfix --
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>
map <leader>f :Leaderf<SPACE>
let g:Lf_ShortcutF = '<C-P>'
" https://vi.stackexchange.com/questions/17896/how-to-move-to-parent-directory-with-leaderf
" This way you can press <tab> to go to LeaderfFile normal mode and then press
" u to reopen LeadefFile with parent folder.
let g:Lf_NormalMap = { "File":   [["u", ':LeaderfFile ..<CR>']] }

""" {{{ movement
nmap <silent>gm :call cursor(0, len(getline('.'))/2)<CR>
nmap ge $
" easymotion
" Turn on case-insensitive feature
nmap , <Plug>(easymotion-prefix)
nmap ; <Plug>(easymotion-lineanywhere)
map  s <Plug>(easymotion-sn)
omap s <Plug>(easymotion-tn)
" 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap E <Plug>(ale_previous_wrap)
nmap e <Plug>(ale_next_wrap)
" tabs
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
" buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
""" movement }}}

let g:UltiSnipsExpandTrigger="<c-l>" " 因为YouCompleteMe和ultisnips都映射了tab键引起冲突, 这儿更换掉ultisnips的映射
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" {{{ Automatically fitting a quickfix window height
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
" }}}
