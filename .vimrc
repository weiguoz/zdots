""" 2005: weiguoz@github created this file by Guanjun Zhang' helping

" bundle {{{
set secure nocompatible
filetype off                   " 必须先关闭文件类型检查
set rtp+=/Users/weiguo/.vim/vundle/Vundle.vim " 规定Vundle的路径
call vundle#rc('/Users/weiguo/.vim/vundle') " 规定插件的安装路径
" 需要安装的插件列表放在这里
" Bundle 'gmarik/vundle'
Bundle 'VundleVim/Vundle.vim'
"such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Bundle 'skywind3000/asyncrun.vim'
""" colorschema
" Bundle 'tomasr/molokai'
Bundle 'NLKNguyen/papercolor-theme'
" lepture/vim-velocity
Bundle 't9md/vim-choosewin'
Bundle 'kshenoy/vim-signature'
" Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/grep.vim'
" Bundle 'mxw/vim-jsx'
Bundle 'vim-scripts/FencView.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
" replaced by ale
" Bundle 'vim-syntastic/syntastic'
Bundle 'dense-analysis/ale'
" Bundle 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
Bundle 'davidhalter/jedi-vim'
Bundle 'lfv89/vim-interestingwords'
" 'sjl/gundo.vim'
Bundle 'simnalamburt/vim-mundo'
Bundle 'SirVer/ultisnips'
"  有 SirVer/ultisnips 为啥还需要 honza/vim-snippets 呢
Bundle 'fatih/vim-go'
"""""""" following 2 plugins replaced by LeaderF by Yggdroot@newsmth
" 'kien/ctrlp.vim'
" 'vim-scripts/mru.vim'
" install then do: install.sh
"Bundle 'Yggdroot/LeaderF', {'do': './install.sh'}
" Bundle 'ervandew/supertab'
" git plugin
" replace airblade/vim-gitgutter by vim-signify
Bundle 'mhinz/vim-signify'
" Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'
" statusbar
Bundle 'vim-airline/vim-airline'
" word jump by <leader><leader>w / b(ack)
Bundle 'easymotion/vim-easymotion'
Bundle 'Valloric/YouCompleteMe', {'do': 'python3 install.py --system-libclang --clang-completer --go-completer'}
" https://github.com/junegunn/fzf#as-vim-plugin
" set rtp+=/usr/local/opt/fzf
" }}}

" general settings {{{
" vimrc修改后自动加载
autocmd! bufwritepost .vimrc source %
" 自动补全
" 让vim的补全菜单行为与一般ide一致
set completeopt=longest,menu
let g:mapleader=" "
au BufWrite /private/etc/pw.* set nowritebackup nobackup " Don't write backup file if vim is being called by "chpass"
filetype plugin indent on      " 重新打开文件类型检查
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
" statusline {{{ replaced by : vim-airline/vim-airline
" set cmdheight=1
" set report=0
" set laststatus=2
" set statusline=buf[%n,\ %{&encoding}]:%F " Buf:\ %2*%-3.3n%0*\ buffer number%n  file name%F/f
" set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
" set statusline+=%{&fileformat}]\   " file format
" set statusline+=%=          " right align
" set statusline+=\ \ [%03v\:0x%-4B\ %03l\/%L\=%p%%]
" set statusline+=\ \ %h%1*%m%r%w%0*  " flag
" set statusline+=\ %{strftime(\"%H:%M\")}
" " set statusline+=\ %#warningmsg#
" " set statusline+=\ %{SyntasticStatuslineFlag()}
" " set statusline+=\ %*
" au InsertEnter * hi statusline guibg=Purple ctermfg=4 guifg=Black ctermbg=13
" au InsertLeave * hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=18
" hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=18
" }}}

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
" }}}

colorscheme PaperColor " molokai herald 256-jungle
" autocmd BufNewFile,BufRead *.go colorscheme PaperColor
" let g:airline_theme='molokai'
set background=dark

"{{{ 插件配置 +++
let NERDTreeWinPos='left'
let NERDTreeHighlightCursorline=0    " 高亮当前行
let NERDTreeShowHidden=1             " 显示隐藏文件
let NERDChristmasTree=1              " 色彩显示
" ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$']

set autochdir

" interestingwords
let g:interestingWordsCycleColors=1
" YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/w7udots/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=1

" linter {{{ ale
" 20190122改 syntasitic 为 ale
let g:ale_lint_on_text_changed = 'normal'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" 命令 :Errors 弹出loc_list
" By default, all available tools for all supported languages will be run.
" If you want to only select a subset of the tools,
" you can define b:ale_linters for a single buffer, or g:ale_linters globally.
" 'go': ['golint', 'govet', 'gometalinter'],
let b:ale_linters = {
            \'go': ['golint', 'gopls'],
            \'cpp': ['clang'],
            \'c': ['clang'],
            \}
" }}}

" undo {{{
let g:gundo_width=50
let g:gundo_preview_height=40
let g:gundo_right=1
" }}}
" let MRU_Max_Entries=400

" jedi {{{
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#goto_definitions_command = "<leader>d"
" let g:jedi#usages_command = "<leader>u"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#documentation_command = "K"
" }}}

" 对齐线段配置 vim-indent-guides
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=6
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=7

"{{{ tagbar
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
"}}}

" {{{ easymotion
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" }}}
"}}} 插件配置 ---

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

"{{{vim-airline comments +++
" let loaded_trailing_whitespace_plugin=1
" " Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" highlight ExtraWhitespace ctermbg=darkred guibg=#382424
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"
" " The above flashes annoyingly while typing, be calmer in insert mode
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" vim-airline comments ---
"}}}

" {{{ functions
" Run :FixWhitespace to remove end of line white space
function! s:FixWhitespace(line1,line2)
    let l:save_cursor=getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

function! MoveRatioOfWindow(move, r)
    let height=winheight(0)
    if a:move == 'up'
        let key="k"
    else
        let key="j"
    endif
    execute 'normal! ' . height * a:r / 100 . key
endfunction

function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

func! CompileRun()
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
        silent exec "!rm -rf %< %<.dSYM"
    endif
endfunc

function! AddDesc()
    call AddTemplate()
    call AddTitle()
    exec "w"
endf

function! AddTitle()
    if (&filetype=="c" || &filetype=="cpp" || &filetype=="cxx")
        call append(0, "/*+++++++++++++++++++++++ <Description> ++++++++++++++++++++++++++")
        call append(1, " * @Brief:")
        call append(2, " *")
        call append(3, " * @History:")
        call append(4, " * ---------------------------------")
        call append(5, " * @author: w7u created [".strftime("%Y-%m-%d")."]")
        call append(6, " *")
        call append(7, " * -------------------------------------------------------------*/")
    else
        call append(0, "# +++++++++++++++++++++++++ <Description> +++++++++++++++++++++++++++++++")
        call append(1, "# @Brief:")
        call append(2, "#")
        call append(3, "# @History:")
        call append(4, "# ---------------------------------")
        call append(5, "# @author: w7u created [".strftime("%Y-%m-%d")."]")
        call append(6, "#")
        call append(7, "# -------------------------------------------------------------------------")
    endif
endf

function! AddTemplate()
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

" {{{ shortcut, movements & jumps
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
command! -nargs=0 Adddesc :call AddDesc() " 源码说明头
nnoremap <silent> <c-k> :call MoveRatioOfWindow('up', 40)<CR>
nnoremap <silent> <c-j> :call MoveRatioOfWindow('down', 40)<CR>
nmap <Leader>j :call GotoJump()<CR>
nmap <c-c> :ChooseWin<CR>

""" go
au FileType go nmap gs <Plug>(go-def-vertical)
au FileType go nmap <Leader>r :GoReferrers<CR>
au FileType go nmap ds :GoDefStack<CR>
" (go-def-tab) (go-def-split)

nmap <Leader>l :ALEToggle<CR>
imap <silent>ww <Esc> :w<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>h :MundoToggle<CR>
nmap <leader>a :AsyncRun<space>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>

" leaderf mapping
map <leader>f :Leaderf<SPACE>
let g:Lf_ShortcutF = '<C-P>'
" https://vi.stackexchange.com/questions/17896/how-to-move-to-parent-directory-with-leaderf
" This way you can press <tab> to go to LeaderfFile normal mode and then press
" u to reopen LeadefFile with parent folder.
let g:Lf_NormalMap = { "File":   [["u", ':LeaderfFile ..<CR>']] }
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
" }}}
