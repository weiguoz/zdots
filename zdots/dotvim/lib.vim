" undo3 {{{
function! DirUndo()
    if has('nvim')
        let $DUNDO=$HOME."/.vim/undo/nv"
    else
        let $DUNDO=$HOME."/.vim/undo/v"
    endif

    if isdirectory($DUNDO)==0
        :silent !mkdir -p $DUNDO > /dev/null 2>&1
    endif
    set undodir=$DUNDO
    set undolevels=500 " undo次数
    set undofile       " :wq之后可继续撤销, 高级用法是 :earlier :later
    set colorcolumn=+1
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
            call append(line(".")+8, "    printf(\"Hello\\n\");")
            call append(line(".")+9, "    return 0;")
            call append(line(".")+10, "}")
            :10
        endif
    elseif (&filetype == "go")
        call setline(1, "package main")
        call append(line("."), "")
        call append(line(".")+1, "import \"fmt\"")
        call append(line(".")+2, "")
        call append(line(".")+3, "func main() {")
        call append(line(".")+4, "\tfmt.Println(\"Hello\")")
        call append(line(".")+5, "}")
        :1
    endif
endfunc
" }}}

" {{{ https://stackoverflow.com/a/12739441/479812
function Rand()
    return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfunction
" }}}

