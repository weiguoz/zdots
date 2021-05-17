" " {{{ NERDTree, NerdTreeFind...
" command F :NERDTreeFind
" let NERDTreeWinPos='left'
" let NERDTreeHighlightCursorline=0    " 高亮当前行
" let NERDTreeShowHidden=1             " 显示隐藏文件
" let NERDChristmasTree=1              " 色彩显示
" " ignore files in NERDTree
" let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$']
" "Quit when where is no active buffer https://github.com/preservim/nerdtree/issues/21#issuecomment-157212312
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " }}}

let g:interestingWordsCycleColors=1 " interestingwords

" " {{{ YouCompleteMe
" let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" let g:ycm_confirm_extra_conf=1
" let g:ycm_use_clangd = "Always"
" " xcode-select --install brings commandlinetools/../clangd
" let g:ycm_clangd_binary_path = "/Library/Developer/CommandLineTools/usr/bin/clangd"
" let g:ycm_filetype_whitelist = {
"             \ "c":1,
"             \ "cpp":1,
"             \ "sh":1,
"             \ "zsh":1,
"             \ "python":1,
"             \ "go":1,
"             \ }
" "{{{ python
" if has('python3')
"     " silent! python3 1 https://github.com/vim/vim/issues/3117 解决启动时因为python3的报警
"     " let g:ycm_server_python_interpreter='/usr/local/bin/python3' 正确设置好 python，则不需要这行配置
"     let g:pymode_rope=0
"     nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" endif
" "}}}
" }}}

" {{{ coc
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-explorer',
            \ 'coc-pyright',
            \ 'coc-snippets']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap E <Plug>(coc-diagnostic-prev)
nmap e <Plug>(coc-diagnostic-next)

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" {{{ coc-explorer
nnoremap <space>e :CocCommand explorer<CR>
" }}}
" }}}

" " {{{ ale
" " 20190122改 syntasitic 为 ale
" let g:ale_lint_on_text_changed = 'always' " normal
" " You can disable this option too
" " if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = '0'
" let g:ale_lint_on_save = '1'
" let g:ale_list_window_size = 4
" let g:ale_set_highlights = 0
" let g:ale_sign_column_always = 1
" let g:ale_open_list = 0
" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '⚠'
" "在vim自带的状态栏中整合ale
" let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ OK']
" " By default, all available tools for all supported languages will be run.
" " If you want to only select a subset of the tools,
" " you can define b:ale_linters for a single buffer, or g:ale_linters globally.
" " 'go': ['golint', 'govet', 'gometalinter'],
" let g:ale_linters = {
"             \'go': ['golint', 'gopls'],
"             \'cpp': ['clang'],
"             \'c': ['clang'],
"             \'python': ['pylint'],
"             \}
" " }}}

" undo {{{
" let g:gundo_width=50
" let g:gundo_preview_height=40
" let g:gundo_right=1
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
" Turn on case-insensitive feature
" nmap , <Plug>(easymotion-prefix)
map  s <Plug>(easymotion-sn)
omap s <Plug>(easymotion-tn)
nmap ; <Plug>(easymotion-bd-jk)
nmap ' <Plug>(easymotion-lineanywhere)
nmap , <Plug>(easymotion-jumptoanywhere)
" }}}

" {{{ vim-airline comments
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
"}}}

" {{{ Leaderf
" let g:Lf_ShortcutF = '<C-P>'
" " https://vi.stackexchange.com/questions/17896/how-to-move-to-parent-directory-with-leaderf
" " This way you can press <tab> to go to LeaderfFile normal mode and then press
" " u to reopen LeadefFile with parent folder.
" let g:Lf_NormalMap = { "File":   [["u", ':LeaderfFile ..<CR>']] }
" }}}"

" {{{ vim-workspace: https://github.com/thaerkh/vim-workspace
" Plug 'thaerkh/vim-workspace' " is sth. bad to GoReferrers
" let g:workspace_session_directory = $HOME . '/.vim/sessions/'
" let g:workspace_persist_undo_history = 1
" let g:workspace_undodir = $HOME . '/.vim/undo/'
" let g:workspace_autosave_always = 1
" let g:workspace_autosave_ignore = ['gitcommit']
" }}}

" {{{ buftabline
" let g:buftabline_show=1
" let g:buftabline_numbers=2
" }}}

" {{{ fzf buffers <- so I remove the buftabline from my plugins
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

command! Buffers0 call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept' }))

function! RGOpt(arg, fullscreen)
  let tokens  = split(a:arg)
  let opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query = join(filter(copy(tokens), 'v:val !~ "^-"'))

  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case '.opts.' -- %s || true'
  let initial_command = printf(command_fmt, shellescape(query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
" Customized Rg, support options like:
" :Rg -C2 -tgo os.remove<enter>
" :Rg -C2 -tgo <enter>, then> os.remove
" :Rg os.remove<enter>
command! -nargs=* -bang Rg call RGOpt(<q-args>, <bang>0)
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
let g:bookmark_sign='♥'
let g:bookmark_auto_save_file=BMWorkDirFileLocation()
"}}}

" ""{{{ bagrat/vim-buffet
" nmap <leader>1 <Plug>BuffetSwitch(1)
" nmap <leader>2 <Plug>BuffetSwitch(2)
" nmap <leader>3 <Plug>BuffetSwitch(3)
" nmap <leader>4 <Plug>BuffetSwitch(4)
" nmap <leader>5 <Plug>BuffetSwitch(5)
" nmap <leader>6 <Plug>BuffetSwitch(6)
" nmap <leader>7 <Plug>BuffetSwitch(7)
" nmap <leader>8 <Plug>BuffetSwitch(8)
" nmap <leader>9 <Plug>BuffetSwitch(9)
" nmap <leader>0 <Plug>BuffetSwitch(10)
" noremap <Tab> :bn<CR>
" noremap <S-Tab> :bp<CR>
" noremap <Leader>q :Bw<CR>
" function! g:BuffetSetCustomColors()
"     hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=7 guibg=#00FF00 guifg=#000000
" endfunction
" let g:buffet_always_show_tabline = 0
" let g:buffet_use_devicons = 1
" let g:buffet_powerline_separators = 1
" let g:buffet_tab_icon = "\uf00a"
" let g:buffet_show_index = 1
" let g:buffet_max_plug = 10
" ""}}}

" {{{ APZelos/blamer.nvim
let g:blamer_enabled=1
let g:blamer_show_in_insert_modes=0
" let g:blamer_show_in_visual_modes=0
let g:blamer_delay = 200
" let g:blamer_prefix = "\t "
let g:blamer_date_format = '%Y-%m-%d %H:%M'
let g:blamer_template = '<author>, <committer-time> • <summary>'
" }}}

" {{{ any-jump
let g:any_jump_disable_default_keybindings = 1
" Normal mode: Jump to definition under cursore
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9
" Normal mode: open previous opened file (after jump)
" nnoremap <leader>ab :AnyJumpBack<CR>
" Normal mode: open last closed search window again
" nnoremap <leader>al :AnyJumpLastResults<CR>
" }}}
