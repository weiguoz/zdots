" {{{ NERDTree
let NERDTreeWinPos='left'
let NERDTreeHighlightCursorline=0    " 高亮当前行
let NERDTreeShowHidden=1             " 显示隐藏文件
let NERDChristmasTree=1              " 色彩显示
" ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$']
" }}}

let g:interestingWordsCycleColors=1 " interestingwords

" {{{ YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=1
let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "sh":1,
            \ "zsh":1,
            \ "python":1,
            \ "go":1,
            \ }
" }}}

" {{{ ale
" 20190122改 syntasitic 为 ale
let g:ale_lint_on_text_changed = 'always' " normal
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = '0'
let g:ale_lint_on_save = '1'
let g:ale_list_window_size = 4
let g:ale_set_highlights = 0
let g:ale_sign_column_always = 1
let g:ale_open_list = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ OK']
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

" {{{ Plug 'nathanaelkane/vim-indent-guides'
" let g:indent_guides_guide_size=1
" let g:indent_guides_start_level=2
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=6
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=7
" }}}

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

" {{{ vim-airline comments +++
" let loaded_trailing_whitespace_plugin=1
" " Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" highlight ExtraWhitespace ctermbg=darkred guibg=#382424
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"
" " The above flashes annoyingly while typing, be calmer in insert mode
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" }}}

" {{{ git-messenger
nmap <silent>gm <Plug>(git-messenger)
let g:git_messenger_always_into_popup=v:true
let g:git_messenger_include_diff="current"
hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210
" }}}
