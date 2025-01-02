" {{{ AsyncRun
nmap <leader>a :AsyncRun<space>
" open quickfix window automatically when AsyncRun is executed
let g:asyncrun_open = 8
" ring the bell to notify you job finished
" let g:asyncrun_bell = 1
nnoremap <leader>q :call asyncrun#quickfix_toggle(6)<cr>
" {{{ complie a single cpp/c file & run
" func! CompileAndRun()
"     let opt = "-DDBG -Wall -Wextra -Werror -Wshadow -g" " -Wconversion
"     if (&filetype == "c")
"         exec "!clang ".opt." -o %< % && (./%< ; rm -rf %< %<.dSYM)"
"     elseif (&filetype == "cpp")
"         silent exec "!clang++ ".opt." -std=c++20 -o %< % && (./%< ; rm -rf %< %<.dSYM)"
"     elseif (&filetype == "go")
"         exec "!go run %"
"     else
"         echohl WarningMsg | echo &filetype" is not a kind of runnable filetype" | echohl None
"     endif
"     " if !v:shell_error
"     "   ...
"     " endif
" endfunc
"
" if !has('nvim') " placed in .vimrc
"     au FileType cpp,c,go command! -nargs=0 -bang Run call CompileAndRun()
"     au FileType cpp,c,go nnoremap <silent> run :exec 'Run'<CR>
" endif
" }}}
au FileType cpp nnoremap <silent> run :AsyncRun clang++ -DDBG -Wall -Wextra -Werror -Wshadow -g -std=c++20 -o %< % && (./%< ; rm -rf %< %<.dSYM)<cr>
au FileType c nnoremap <silent> run :AsyncRun clang -DDBG -Wall -Wextra -Werror -Wshadow -g -o %< % && (./%< ; rm -rf %< %<.dSYM)<cr>
au FileType go nnoremap <silent> run :AsyncRun go run %<cr>
" }}}

" {{{ easymotion -> justinmk/vim-sneak
""" " Search paste is broken, so I removed the plugin.
""" " More details https://github.com/easymotion/vim-easymotion/issues/408
""" let g:EasyMotion_smartcase = 1 " Turn on case-insensitive feature
""" map  / <Plug>(easymotion-sn)
""" omap / <Plug>(easymotion-tn)
""" nmap , <Plug>(easymotion-bd-jk)
""" " nmap ; <Plug>(easymotion-lineanywhere)
""" " <Plug>(easymotion-jumptoanywhere)
map f <Plug>Sneak_f
map F <Plug>Sneak_F
" }}}

" {{{ vim-rooter
" vim-rooter will unset &autochdir if it's set.
let g:rooter_patterns = ['Rakefile', '.git/']
" }}}

"{{{ any-jump https://github.com/pechorin/any-jump.vim#settings
" Show line numbers in search rusults
let g:any_jump_list_numbers = 1
" Auto search references
let g:any_jump_references_enabled = 1
" Auto group results by filename
let g:any_jump_grouping_enabled = 0
" Amount of preview lines for each search result
let g:any_jump_preview_lines_count = 5
" Max search results, other results can be opened via [a]
let g:any_jump_max_search_results = 10
" Prefered search engine: rg or ag
let g:any_jump_search_prefered_engine = 'rg'

" Search results list styles:
" - 'filename_first'
" - 'filename_last'
let g:any_jump_results_ui_style = 'filename_first'
" Any-jump window size & position options
let g:any_jump_window_width_ratio  = 0.6
let g:any_jump_window_height_ratio = 0.6
let g:any_jump_window_top_offset   = 4
" Customize any-jump colors with extending default color scheme:
let g:any_jump_colors = { "help": "Comment" }
" Or override all default colors
let g:any_jump_colors = {
            \"plain_text":         "Comment",
            \"preview":            "Comment",
            \"preview_keyword":    "Operator",
            \"heading_text":       "Function",
            \"heading_keyword":    "Identifier",
            \"group_text":         "Comment",
            \"group_name":         "Function",
            \"more_button":        "Operator",
            \"more_explain":       "Comment",
            \"result_line_number": "Comment",
            \"result_text":        "Statement",
            \"result_path":        "String",
            \"help":               "Comment"
            \}
" Disable default any-jump keybindings (default: 0)
let g:any_jump_disable_default_keybindings = 1
" Remove comments line from search results (default: 1)
let g:any_jump_remove_comments_from_results = 1
" Custom ignore files
" default is: ['*.tmp', '*.temp']
let g:any_jump_ignored_files = ['*.tmp', '*.temp']
" Search references only for current file type
" (default: false, so will find keyword in all filetypes)
let g:any_jump_references_only_for_current_filetype = 0
" Disable search engine ignore vcs untracked files
" (default: false, search engine will ignore vcs untracked files)
let g:any_jump_disable_vcs_ignore = 0

" maps
let g:any_jump_disable_default_keybindings = 1
" Normal mode: Jump to definition under cursore
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9
" Normal mode: open previous opened file (after jump)
nnoremap <leader>J :AnyJumpBack<CR>
" Normal mode: open last closed search window again
" nnoremap <leader>al :AnyJumpLastResults<CR>
" }}}

" {{{ fzf buffers <- so I remove the buftabline from my plugins
" fzf quicks
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept' }))

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit' }

function! RGOptFun(arg, fullscreen)
    let tokens  = split(a:arg)
    let opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
    let query = join(filter(copy(tokens), 'v:val !~ "^-"'))

    let command_fmt = 'rg --column --no-heading --color=always --smart-case '.opts.' -- %s || true'
    let initial_command = printf(command_fmt, shellescape(query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', query, '--bind', 'change:reload:'.reload_command, '--preview-window=right:70%']}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
noremap <silent>s :call RGOptFun(expand('<cword>'), 0)<CR>
" Customized Rg, support options like:
" :Rg -C2 -tgo os.remove<enter>
" :Rg -C2 -tgo <enter>, then> os.remove
" :Rg os.remove<enter>
command! -nargs=* -bang Rg call RGOptFun(<q-args>, <bang>0)
" }}}

" {{{ vim-mark
nnoremap <leader>M :MarkClear<CR> " 与外部执行命令的区别是打开的目录不同，这个是当前文件所在目录
" }}}

" {{{ francoiscabrol/ranger.vim
" let g:ranger_map_keys = 0
" let g:ranger_open_new_tab = 1
" nmap <leader>l :RangerCurrentFileExistingOrNewTab<CR>
" }}}

" {{{ vim-tmux-navigator
let g:tmux_navigator_save_on_switch = 2
let g:tmux_navigator_disable_when_zoomed = 1
" }}}
" nnoremap <leader>" :silent !tmux split-window -c %:p:h<CR> " 与外部执行命令的区别是打开的目录不同，这个是当前文件所在目录

" {{{ copilot.vim
" https://github.com/github/copilot.vim/blob/1a55183ef9347d6f420406a3746474b6b9fb9ef5/doc/copilot.txt#L104
imap <silent><script><expr> <c-f> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

"
" tpope [workaround] https://github.com/community/community/discussions/16800#discussioncomment-2848953
" let g:copilot_node_command = "/opt/homebrew/opt/node@16/bin/node"
" it seems that the above is not needed anymore since 2023-01-06
" }}}

" {{{ vim-commentary
noremap <c-_> :Commentary<cr>
vnoremap <c-_> :Commentary<cr>
inoremap <c-_> <Esc>:Commentary<cr>0
" }}}
