""" Author: weiguoz@github
""" Events:
""" - 2015 created this file by Guanjun Zhang's helping

" {{{ vim-plug, turn vundle/bundle to vim-plugin at 2019.11.18
filetype off                   " 必须先关闭文件类型检查
" set secure nocompatible
" set rtp+=/Users/weiguo/.vim/vundle/Vundle.vim " 规定Vundle的路径
" call vundle#rc('/Users/weiguo/.vim/vundle') "   规定插件的安装路径
" Bundle 'VundleVim/Vundle.vim'
" Bundle ...
" Bundle 'kshenoy/vim-signature'
let g:plugged_home = '~/.vim/plugged'
call plug#begin(g:plugged_home)
    "such as: AsyncRun tmux send-keys -t2 \"go test\" enter
    Plug 'skywind3000/asyncrun.vim'
    """ colorschema
    Plug 'NLKNguyen/papercolor-theme'
    Plug 't9md/vim-choosewin'
    Plug 'kshenoy/vim-signature'
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/grep.vim'
    " Plug 'mxw/vim-jsx'
    Plug 'vim-scripts/FencView.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " replaced by ale
    " Plug 'vim-syntastic/syntastic'
    Plug 'dense-analysis/ale'
    " Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
    Plug 'davidhalter/jedi-vim'
    Plug 'lfv89/vim-interestingwords'
    Plug 'simnalamburt/vim-mundo'
    Plug 'SirVer/ultisnips'
    "  有 SirVer/ultisnips 为啥还需要 honza/vim-snippets 呢
    Plug 'fatih/vim-go'
    """""""" following 2 plugins replaced by LeaderF by Yggdroot@newsmth
    " 'kien/ctrlp.vim'
    " 'vim-scripts/mru.vim'
    " install then do: install.sh
    Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
    " Plug 'ervandew/supertab'
    " git plugin
    " replace airblade/vim-gitgutter by vim-signify
    Plug 'mhinz/vim-signify'
    " Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    " statusbar
    Plug 'vim-airline/vim-airline'
    " word jump by <leader><leader>w / b(ack)
    Plug 'easymotion/vim-easymotion'
    Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --system-libclang --clang-completer --go-completer'}
    " Vim client for TabNine which is the all-language autocompleter
    " TabNine uses deep learning to help you write code faster.
    Plug 'zxqfl/tabnine-vim'
call plug#end()
" }}}

filetype plugin indent on
set autochdir

" general settings {{{
" 自动加修改中的 .vimrc 文件
autocmd! bufwritepost .vimrc source %
" 自动补全
" 让vim的补全菜单行为与一般ide一致
set completeopt=longest,menu
let g:mapleader=" "
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
set nu " rnu relativenumber 相对行号
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
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
" }}}

colorscheme PaperColor " molokai herald 256-jungle
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
" }}}

" {{{ shortcut, movements & jumps
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
command! -nargs=0 Adddesc :call AddDesc() " 源码说明头
nnoremap <silent> <c-k> :call MoveRatioOfWindow('up', 40)<CR>
nnoremap <silent> <c-j> :call MoveRatioOfWindow('down', 40)<CR>
nmap <Leader>j :call GotoJump()<CR>
nmap <c-c> :ChooseWin<CR>

""" go
au FileType go nmap gs <Plug>(go-def-vertical)
au FileType go nmap ds :GoDefStack<CR>
au FileType go nmap <Leader>r :GoReferrers<CR>
" (go-def-tab) (go-def-split)

imap <silent>ww <Esc> :w<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

nmap <Leader>l :ALEToggle<CR>
nmap <leader>h :MundoToggle<CR>
nmap <leader>a :AsyncRun<space>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>

map <leader>f :Leaderf<SPACE>
let g:Lf_ShortcutF = '<C-P>'
" https://vi.stackexchange.com/questions/17896/how-to-move-to-parent-directory-with-leaderf
" This way you can press <tab> to go to LeaderfFile normal mode and then press
" u to reopen LeadefFile with parent folder.
let g:Lf_NormalMap = { "File":   [["u", ':LeaderfFile ..<CR>']] }

""" movement +++
nmap <silent>gm :call cursor(0, len(getline('.'))/2)<CR>
nmap ge $
" easymotion
" Turn on case-insensitive feature
nmap , <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f2)
nmap ; <Plug>(easymotion-lineanywhere)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap tn :tabnext<CR>
nmap tp :tabprevious<CR>
nmap e <Plug>(ale_previous_wrap)
nmap E <Plug>(ale_next_wrap)
""" movement ---

let g:UltiSnipsExpandTrigger="<c-l>" " 因为YouCompleteMe和ultisnips都映射了tab键引起冲突, 这儿更换掉ultisnips的映射
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

" jedi {{{
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#goto_definitions_command = "<leader>d"
" let g:jedi#usages_command = "<leader>u"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#documentation_command = "K"
" }}}
