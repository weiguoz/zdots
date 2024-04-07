" {{{ coc
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-word',
            \ 'coc-explorer',
            \ 'coc-pyright',
            \ 'coc-snippets']

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap E <Plug>(coc-diagnostic-prev)
nmap e <Plug>(coc-diagnostic-next)
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>w :Windows<CR>
noremap t :BTags<CR>

""" {{{ copied from https://github.com/neoclide/coc.nvim README.md
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif
" }}}

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)

" Use h to show documentation in preview window.
nnoremap <leader>h :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" {{{ coc-explorer
nnoremap <leader>e :CocCommand explorer<CR>
" }}}
" }}}

" {{{ AsyncRun
nmap <leader>a :AsyncRun<space>
" open quickfix window automatically when AsyncRun is executed
let g:asyncrun_open = 1 " we don't need set the quickfix window height due to AdjustWindowHeight does
" ring the bell to notify you job finished
" let g:asyncrun_bell = 1
" nnoremap <leader>r :call asyncrun#quickfix_toggle(6)<cr>
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

" {{{ disabled <dstein64/vim-win>
" map cc <plug>WinWin
" let g:win_ext_command_map = {"\<cr>": 'Win#exit'}
" }}}

"{{{ liuchengxu/vista.vim
noremap t :silent! Vista finder coc<CR>
" same function
noremap <silent> <leader>t :Vista!!<CR>
let g:vista_fzf_preview = ['right:50%']
" It's a little bit weird that thers is connection between vista and statusline(vim-airline)
" https://github.com/liuchengxu/vista.vim#show-the-nearest-methodfunction-in-the-statusline
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
"}}}

" {{{ easymotion
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Turn on case-insensitive feature
" nmap , <Plug>(easymotion-prefix)
map s <Plug>(easymotion-sn)
omap s <Plug>(easymotion-tn)
nmap , <Plug>(easymotion-bd-jk)
nmap ; <Plug>(easymotion-lineanywhere)
" nmap ' <Plug>(easymotion-jumptoanywhere)
" }}}

" {{{ git-messenger
nmap <silent>gm <Plug>(git-messenger)
let g:git_messenger_always_into_popup=v:true
let g:git_messenger_include_diff="current"
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

command! Buffersdel call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept' }))

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

"{{{ MattersGroeger/vim-bookmarks
" Finds the Git super-project directory.
function! g:BMWorkDirFileLocation()
    let filename = 'vim_bookmarks'
    let location = ''
    if isdirectory('.git')
        " Current work dir is git's work tree
        let location = getcwd().'/.git'
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', '.;')
    endif
    if len(location) > 0
        return location.'/'.filename
    else
        return getcwd().'/.'.filename
    endif
endfunction
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_save_file=BMWorkDirFileLocation()
"}}}

" {{{ francoiscabrol/ranger.vim
let g:ranger_map_keys = 0
let g:ranger_open_new_tab = 1
nmap <leader>l :RangerCurrentFileExistingOrNewTab<CR>
" }}}

"{{{ honza/vim-snippets
let g:snips_author=$USER
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
"}}}

" {{{ APZelos/blamer.nvim
let g:blamer_enabled = 1
" nmap <leader>b :BlamerToggle<CR>
let g:blamer_delay = 500
" let g:blamer_relative_time = 1
let g:blamer_date_format = '%Y.%m.%d'
let g:blamer_show_in_visual_modes = 1
let g:blamer_show_in_insert_modes = 0
" }}}

" {{{ vim-tmux-navigator
let g:tmux_navigator_save_on_switch = 2
let g:tmux_navigator_disable_when_zoomed = 1
" }}}
" nnoremap <leader>" :silent !tmux split-window -c %:p:h<CR> " 与外部执行命令的区别是打开的目录不同，这个是当前文件所在目录

" {{{ andymass/vim-matchup
" display parents
" nnoremap <leader>p :<c-u>MatchupWhereAmI?<cr>
" }}}

" {{{ copilot.vim
" https://github.com/github/copilot.vim/blob/1a55183ef9347d6f420406a3746474b6b9fb9ef5/doc/copilot.txt#L104
imap <silent><script><expr> <C-S> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
" tpope [workaround] https://github.com/community/community/discussions/16800#discussioncomment-2848953
" let g:copilot_node_command = "/opt/homebrew/opt/node@16/bin/node"
" it seems that the above is not needed anymore since 2023-01-06
" }}}

" {{{ vim-commentary
noremap <c-_> :Commentary<cr>
vnoremap <c-_> :Commentary<cr>
inoremap <c-_> <Esc>:Commentary<cr>0
" }}}
