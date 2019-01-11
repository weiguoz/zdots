" myxjtu@gmail.com created@2005 with help from Guanjun Zhang

" {{{ bundle
set secure nocompatible
filetype off                   " 必须先关闭文件类型检查
set rtp+=/Users/weiguo/.vim/vundle/Vundle.vim " 规定Vundle的路径
call vundle#rc('/Users/weiguo/.vim/vundle') " 规定插件的安装路径
" 需要安装的插件列表放在这里
" Bundle 'gmarik/vundle'
Bundle 'VundleVim/Vundle.vim'
" lepture/vim-velocity
Bundle 't9md/vim-choosewin'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/grep.vim'
" Bundle 'mxw/vim-jsx'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/FencView.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-syntastic/syntastic'
Bundle 'davidhalter/jedi-vim'
Bundle 'lfv89/vim-interestingwords'
Bundle 'sjl/gundo.vim'
Bundle 'simnalamburt/vim-mundo'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'fatih/vim-go'
Bundle 'tomasr/molokai'
"""""""" following 2 plugins replaced by LeaderF by Yggdroot@newsmth
" 'kien/ctrlp.vim'
" 'vim-scripts/mru.vim'
" install then do: install.sh
Bundle 'Yggdroot/LeaderF'
Bundle 'Valloric/YouCompleteMe'
" Bundle 'ervandew/supertab'
" Bundle 'docker/docker'
" Bundle 'tpope/vim-fugitive' git plugin
" install godef in GFW http_proxy=127.0.0.1:8087 go get -u github.com/nsf/gocode
" http://blog.perlfect.me/2013/07/13/go-coding-with-vim/
let g:go_disable_autoinstall = 1
let g:ycm_global_ycm_extra_conf='~/w7udots/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=1
" }}}

" general settings {{{
au BufWrite /private/etc/pw.* set nowritebackup nobackup " Don't write backup file if vim is being called by "chpass"
filetype plugin indent on      " 重新打开文件类型检查
filetype plugin on      " 重新打开文件类型检查
autocmd FileType java setlocal omnifunc=javacomplete#Complete
syntax enable
set t_Co=256
set ruler
set showcmd
set showmatch
set showmode
au filetype c,cpp,javascript,go set cc=81
au BufNewFile,BufRead *.vm,*.html,*.htm,*.shtml,*.stm set ft=velocity
set cursorline " set cursorcolumn
set backspace=indent,eol,start
" set formatoptions-=croq " don't continue comments when pushing o/O
""""""""""""缩进""""""""""""
set smarttab
set smartindent
set ts=4 sw=4 ai et
set nu
set mouse-=a           " set if mousemodel=extend
" set rnu              " relativenumber 相对行号
set linebreak	       " 不在单词中间折行
set viminfo+=!
set foldmethod=marker  " marker 这个容易操控; /indent 根据缩进自动折行。zm zr来增减折行层次,za打开关闭
" set ffs=unix,dos,mac
" set encoding=utf-8
set encoding=utf-8 fileencodings=utf-8,gbk,gb2312,gb18030 termencoding=utf-8 " 编码控制
" set guifont=Monaco:h9 Monaco:h10 Courier_New:h11:cANSI 指定字体
" Files/Backups
" set nobackup
if has("mac")
    setlocal nowritebackup " set for mac.crontab
else
    set writebackup " keep backup while we are editing
endif
set wrap		" don't wrap/nowrap change text line while terminate screen is full

" undo3
if v:version>=703
    let $DUNDO=$HOME."/.vim/undo"
    if isdirectory($DUNDO)==0
        :silent !mkdir -p $DUNDO > /dev/null 2>&1
    endif
    set undodir=$DUNDO
    set undolevels=500 " undo次数
    set undofile       " :wq之后可继续撤销, 高级用法是 :earlier :later
    set colorcolumn=+1
endif

set ignorecase   " Ignore case when searching
set smartcase
set incsearch
set hlsearch
set nolazyredraw " Don't redraw while executing macros
" set verbose=9	" turn this ON when we want to debug
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set cmdheight=1
set report=0
set laststatus=2
set statusline=buf[%n,\ %{&encoding}]:%F " Buf:\ %2*%-3.3n%0*\ buffer number%n  file name%F/f
" set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
" set statusline+=%{&fileformat}]\   " file format
" set statusline+=%=          " right align
set statusline+=\ \ [%03v\:0x%-4B\ %03l\/%L\=%p%%]
set statusline+=\ \ %h%1*%m%r%w%0*  " flag
set statusline+=\ %{strftime(\"%H:%M\")}
" set statusline+=\ %#warningmsg#
" set statusline+=\ %{SyntasticStatuslineFlag()}
" set statusline+=\ %*
au InsertEnter * hi statusline guibg=Purple ctermfg=4 guifg=Black ctermbg=13
au InsertLeave * hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=18
hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=18

if has("win32") " Fix findstr for Win32
    set grepprg=findstr\ /R\ /S\ /N
    " 设置初始窗口位置、大小
    if has("gui")
        set guioptions-=T " 隐藏gVim工具栏，set go=" 隐藏工具栏和菜单栏
        set guioptions-=L " 隐藏gVim左边滚动条
        set lines=35
        set columns=150
        winpos 0 0
    endif
endif

" jsx/javascript
" let g:jsx_ext_required = 0
"
" 打开大文件优化 http://vim.wikia.com/wiki/Faster_loading_of_large_files
"   if !exists("my_auto_commands_loaded")
"       let my_auto_commands_loaded=1
"       let g:LargeFile=1024 * 1024 * 10
"       augroup LargeFile
"           autocmd BufReadPre
"                       \ * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
"       augroup END
"   endif
" }}}

colorscheme molokai " molokai herald 256-jungle

" {{{ compile and execute
func CompileRun()
    silent exe "w"
    " compile_args=-DDBG -Wall -Wextra -Werror -Wconversion -Wshadow -g -std=c++11
    if (&filetype=="c")
        exec "!clang   -DDBG -Wall -Wextra -Werror -Wshadow -g -o %< %"
    elseif (&filetype=="cpp" ||&filetype=="cxx")
        exec "!clang++ -DDBG -Wall -Wextra -Werror -Wshadow -g -std=c++14 -o %< %"
    else
        echohl WarningMsg | echo "filetype["&filetype"] isn't a c/cpp file" | echohl None
        return
    endif
    if !v:shell_error
        exec "!./%<"
        silent exec "!rm -f %<"
        silent exec "!rm -rf %<.dSYM"
        " diffthis echoerr
    endif
endfunc
" }}}

" {{{ 源码说明头
command! -nargs=0 Adddesc :call AddDesc()
function AddDesc()
    call AddTemplate()
    call AddTitle()
    exec "w"
endf

function AddTitle()
    if (&filetype=="c" || &filetype=="cpp" || &filetype=="cxx")
        call append(0, "/*{{{+++++++++++++++++++++++ <Description> ++++++++++++++++++++++++++")
        call append(1, " * @Brief:")
        call append(2, " *")
        call append(3, " * @History:")
        call append(4, " * ---------------------------------")
        call append(5, " * @author: w7u created [".strftime("%Y-%m-%d")."]")
        call append(6, " *")
        call append(7, " * -------------------------------------------------------------}}}*/")
    else
        call append(0, "# {{{ +++++++++++++++++++++++++ <Description> +++++++++++++++++++++++++++++++")
        call append(1, "# @Brief:")
        call append(2, "#")
        call append(3, "# @History:")
        call append(4, "# ---------------------------------")
        call append(5, "# @author: w7u created [".strftime("%Y-%m-%d")."]")
        call append(6, "#")
        call append(7, "# -------------------------------------------------------------------------}}}")
    endif
endf

function AddTemplate()
    if (&filetype=="c" || &filetype=="cpp" || &filetype=="cxx")
        call append(0, "#include <cstdio>")
        let index=1
    else
        return
    endif
    call append(index+1, "#ifdef DBG")
    call append(index+2, "int main() {")
    call append(index+3, "    printf(\"TODO\\n\");")
    call append(index+4, "	return 0;")
    call append(index+5, "}")
    call append(index+6, "#endif")
endf
" }}}

" {{{ 插件配置
let NERDTreeWinPos='left'            " tree 目录在右边right
let NERDTreeHighlightCursorline=0    " 高亮当前行
let NERDTreeShowHidden=1             " 显示隐藏文件
let NERDChristmasTree=1              " 色彩显示
set autochdir

" 历史记录保存、载入
function SourceSession()
    silent exe ":source Session.vim"
endfunction
command! -nargs=0 L :call SourceSession()

" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list=0 " 1  enable jump next err-point with lne(xt)/lprev
let g:syntastic_error_symbol = "▶▶"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_check_on_wq=1
let g:syntastic_auto_jump=1
let g:syntastic_loc_list_height=5
let g:syntastic_auto_loc_list = 0
nnoremap sn :lnext<cr>
nnoremap sp :lprevious<cr>
" 命令 :Errors 弹出loc_list

" {{{
let g:gundo_width=50
let g:gundo_preview_height=40
let g:gundo_right=1
" }}}
" let MRU_Max_Entries=400

" let g:godef_split=2

" JSX syntax highlighting and indenting will be enabled only for files with
" the .jsx extension. If you would like JSX in .js files, add
let g:jsx_ext_required = 0

" 对齐线段配置 vim-indent-guides
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=6
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=7
"}}}

" {{{ mappings
imap jj <Esc>
let g:mapleader=" "
map <leader>f :Leaderf
let g:Lf_ShortcutF = '<C-P>'
map <leader>t :tabNext<CR>
map <leader>c :call CompileRun()<CR>
map <silent> <leader>w <C-W><C-W>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> <leader>m :call InterestingWords('n')<cr>
nnoremap <silent> <leader>M :call UncolorAllWords()<cr>
nnoremap <silent> n :call WordNavigation('forward')<cr>
nnoremap <silent> N :call WordNavigation('backward')<cr>
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nmap ' 10j
nmap " 10k
nnoremap Y y$
let g:UltiSnipsExpandTrigger="<c-l>" " 因为YouCompleteMe和ultisnips都映射了tab键引起冲突, 这儿更换掉ultisnips的映射
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" }}}

"{{{ python
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0
" https://github.com/vim/vim/issues/3117 解决启动时因为python3的报警
if has('python3')
    silent! python3 1
endif
" let g:ycm_server_python_interpreter
"}}}

"{{{ golang
" https://github.com/fatih/vim-go/issues/887
" 解决 vim-go processing function jump_to_declaration list index out of range
let g:go_def_mode = 'godef'
"" https://github.com/golang/lint
" set rtp+=/User/weiguo/go/src/golang.org/x/lint/misc/vim
let g:go_fmt_autosave=1
let g:syntastic_go_checkers=['golint', 'govet', 'errcheck'] " 每种语言都应该设置语法检查器
" autocmd BufWritePost,FileWritePost *.go silent execute 'GoMetaLinter' | cwindow
" GoMetaLinter invoke all possible linters (golint, vet, errcheck, deadcode, etc.) and put
" the result in the quickfix or location list.
" }}}

"{{{ 将代码行最后的无效空格highlight
let loaded_trailing_whitespace_plugin=1
" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:FixWhitespace(line1,line2)
    let l:save_cursor=getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
"}}}
