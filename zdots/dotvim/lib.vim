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

" {{{ SetTitle
function! Write()
    if (&filetype=="c" || &filetype=="cpp")
        exe "ClangFormat"
    endif
    exe "w"
endfunction

func SetTitle()
    if (&filetype == 'sh' || &filetype == 'python')
        if &filetype == 'sh'
            call setline(1, "\#!/bin/sh")
        else
            call setline(1, "\#!/usr/bin/python")
        endif
        call append(line("."), "\#****************************************************************#")
        call append(line(".")+1, "\# ".expand("$USER")." created ".expand("%")." at ".strftime("%F %R"))
        call append(line(".")+2, "\# Function:")
        call append(line(".")+3, "\#***************************************************************#")
        call append(line(".")+4, "")
        :4
    elseif (&filetype == "c" || &filetype == "cpp")
        call setline(1, "\/**")
        call append(line("."), "\ * ".expand("$USER")." created ".expand("%")." at ".strftime("%F %R"))
        call append(line(".")+1, "\ *")
        call append(line(".")+2, "\ * Description:")
        call append(line(".")+3, "\ */")
        call append(line(".")+4, "")
        if expand('%:e') =~? '\v^h%(pp|h|\+\+|xx)?$'
            :4
        else
            if &filetype == "c"
                call append(line(".")+5, "#include <stdio.h>")
            else
                call append(line(".")+5, "#include <cstdio>")
            endif
            call append(line(".")+6, "")
            call append(line(".")+7, "int main() {")
            call append(line(".")+8, "    printf(\"TODO\\n\");")
            call append(line(".")+9, "    return 0;")
            call append(line(".")+10, "}")
            :10
        endif
    endif
endfunc
" }}}
