" {{{ CleanWin32Toolbar
function! CleanWin32Toolbar()
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
endf
" }}}

" undo3 {{{
function! DirUndo()
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
endf
" }}}

" {{{ move
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
" }}}

" {{{ complie a single cpp/c file & run
func! CompileCxxAndRun()
    silent exe "w"
    " compile_args=-DDBG -Wall -Wextra -Werror -Wconversion -Wshadow -g -std=c++11
    if (&filetype=="c")
        exec "!clang   -DDBG -Wall -Wextra -Werror -Wshadow -g -o %< %"
    elseif (&filetype=="cpp")
        exec "!clang++ -DDBG -Wall -Wextra -Werror -Wshadow -g -std=c++17 -o %< %"
    else
        echohl WarningMsg | echo "filetype["&filetype"] isn't a c/cpp file" | echohl None
        return
    endif
    if !v:shell_error
        exec "!./%<"
        silent exec "!rm -rf %< %<.dSYM"
    endif
endfunc
" }}}

" {{{ header help
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

" {{{ self define statusline replaced by : vim-airline/vim-airline
function! SetStatusLine()
    set cmdheight=1
    set report=0
    set laststatus=2
    set statusline=buf[%n,\ %{&encoding}]:%F " Buf:\ %2*%-3.3n%0*\ buffer number%n  file name%F/f
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&fileformat}]\   " file format
    set statusline+=%=          " right align
    set statusline+=\ \ [%03v\:0x%-4B\ %03l\/%L\=%p%%]
    set statusline+=\ \ %h%1*%m%r%w%0*  " flag
    set statusline+=\ %{strftime(\"%H:%M\")}
    " set statusline+=\ %#warningmsg#
    " set statusline+=\ %{SyntasticStatuslineFlag()}
    " set statusline+=\ %*
    au InsertEnter * hi statusline guibg=Purple ctermfg=4 guifg=Black ctermbg=13
    au InsertLeave * hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=18
    hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=18
endf
" }}}

" {{{ https://stackoverflow.com/a/10102604
function! CleanEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        exe 'bw ' . join(buffers, ' ')
    endif
endf
" }}}

function! Write()
    if (&filetype=="cpp" || &filetype=="c" || &filetype=="h" )
        exe "ClangFormat"
    endif
    exe "w"
endfunction