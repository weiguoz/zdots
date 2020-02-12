syntax on

call plug#begin('~/.vim/nv_plugged')
Plug 'NLKNguyen/papercolor-theme' " colorschema joshdick/onedark.vim
Plug 'scrooloose/nerdtree'  " file list
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'vim-airline/vim-airline'  " make statusline awesome
Plug 'vim-airline/vim-airline-themes'  " themes for statusline
Plug 't9md/vim-choosewin'
Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'dense-analysis/ale'  " linters
Plug 'lfv89/vim-interestingwords'
Plug 'SirVer/ultisnips'
Plug 'skywind3000/asyncrun.vim' "such as: AsyncRun tmux send-keys -t2 \"go test\" enter
Plug 'easymotion/vim-easymotion'
" https://github.com/MattesGroeger/vim-bookmarks#usage
Plug 'MattesGroeger/vim-bookmarks'
Plug 'kien/ctrlp.vim'  " fuzzy search files
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " golang
" {{{ git
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'rhysd/git-messenger.vim' " :GitMessenger, nmap <Leader>gm <Plug>(git-messenger)
" }}}
" Plug 'wesleyche/SrcExpl' I don't like tags which used by SrcExpl
" {{{ deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'} " already has vim-go
Plug 'Shougo/deoplete-clangx'
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' } too much noise
" }}}
" {{{ python
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
" }}}
call plug#end()

" path to your python
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2'

filetype indent on

set fileformat=unix
set shortmess+=c

set mouse-=r " enable mouse, or mouse-=a
set number   " always show current line number
" set relativenumber
set smartcase  " better case-sensitivity when searching
set ignorecase " type :fly<press tab> would display `FlyGrep` in commandline
set wrapscan  " begin search from top of file when nothing is found anymore

set expandtab
set tabstop=4
set shiftwidth=4
set fillchars+=vert:\  " remove chars from seperators
set softtabstop=4

set history=1000  " remember more commands and search history
set foldmethod=marker

set nobackup  " no backup or swap file, live dangerously
set noswapfile  " swap files give annoying warning

set breakindent  " preserve horizontal whitespace when wrapping
set showbreak=..
set lbr  " wrap words

set scrolloff=3 " keep three lines between the cursor and the edge of the screen

set undodir=~/.vim/undo
set undofile  " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload

set noshowmode  " keep command line clean
set noshowcmd

set laststatus=2  " always slow statusline

set splitright  " i prefer splitting right and below
set splitbelow

set hlsearch  " highlight search and search while typing
set incsearch
set cpoptions+=x  " stay at seach item when <esc>

set noerrorbells  " remove bells (i think this is default in neovim)
set visualbell
set t_vb=
set viminfo='20,<1000  " allow copying of more than 50 lines to other applications

let g:lucius_style="light"
let g:lucius_contrast="high"
set background=light        " for the light version
let g:one_allow_italics = 1 " I love italic for comments
colorscheme PaperColor " molokai herald 256-jungle onedark

let mapleader = " " " Leader is the space key
let g:mapleader = " "
let maplocalleader = "`"
let g:maplocalleader = "`"
nnoremap <SPACE> <Nop>

" tabs
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
" buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" mapping Esc
cnoremap <Esc> <C-c>
inoremap <c-c> <ESC> :w<CR>

" map S to replace current word with pasteboard
nnoremap cc "_cc
" imap ww <Esc> :w<CR>
nmap qq :q<CR>
nmap <Leader>w :w!<CR>
nmap <Leader>o :on<CR>

" map paste, yank and delete to named register so the content
" will not be overwritten (I know I should just remember...)
nnoremap x "_x
vnoremap x "_x

set clipboard=unnamed

set completeopt=menuone,noselect,noinsert

" affect the complete #candidates number, or just comment it
" set pumheight=5

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

let g:airline_powerline_fonts = 1
let g:airline_section_y = ""
let g:airline#extensions#tabline#enabled = 1

nmap <leader>a :AsyncRun<space>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>
nmap <Leader>j :call GotoJump()<CR>
nmap <c-c> :ChooseWin<CR>

" easy breakpoint python
au FileType python map <silent> <leader>b ofrom pudb import set_trace; set_trace()<esc>
au FileType python map <silent> <leader>B Ofrom pudb import set_trace; set_trace()<esc>
au FileType python map <silent> <leader>j ofrom pdb import set_trace; set_trace()<esc>
au FileType python map <silent> <leader>J Ofrom pdb import set_trace; set_trace()<esc>

" ale options
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_enter = '0'
let g:ale_lint_on_save = '1'

let g:ale_list_window_size = 4
let g:ale_sign_column_always = 0
let g:ale_open_list = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ OK']

" Options are in .pylintrc!
highlight VertSplit ctermbg=253
let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
let b:ale_linters = {
            \'go': ['golint', 'gopls'],
            \'cpp': ['clang'],
            \'c': ['clang'],
            \}

nmap E <Plug>(ale_previous_wrap)
nmap e <Plug>(ale_next_wrap)

" highlight python and self function
autocmd BufEnter * syntax match Type /\v\.[a-zA-Z0-9_]+\ze(\[|\s|$|,|\]|\)|\.|:)/hs=s+1
autocmd BufEnter * syntax match pythonFunction /\v[[:alnum:]_]+\ze(\s?\()/
hi def link pythonFunction Function
autocmd BufEnter * syn match Self "\(\W\|^\)\@<=self\(\.\)\@="
highlight self ctermfg=239

" jedi options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0

" Impsort option
hi pythonImportedObject ctermfg=127
hi pythonImportedFuncDef ctermfg=127
hi pythonImportedClassDef ctermfg=127

nnoremap <C-S> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

function! MakeBracketMaps()
    nnoremap <silent><nowait><buffer> [ :<c-u>exe 'normal '.v:count.'[m'<cr>
    nnoremap <silent><nowait><buffer> ] :<c-u>exe 'normal '.v:count.']m'<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType python call MakeBracketMaps()
augroup END

" neovim options
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" vim-interesting
let g:interestingWordsCycleColors=1 " interestingwords

" vimgutter options
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

" ctrl p options
let g:ctrlp_custom_ignore = '\v\.(npy|jpg|pyc|so|dll)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" movement
nmap ge $

nnoremap <silent> <c-k> :call MoveRatioOfWindow('up', 40)<CR>
nnoremap <silent> <c-j> :call MoveRatioOfWindow('down', 40)<CR>

" move between defs python:
nnoremap [[ [m
nnoremap ]] ]m

" {{{ git-messenger
nmap <silent>gm <Plug>(git-messenger)
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_include_diff = "current"
hi gitmessengerPopupNormal term=None guifg=#eeeeee guibg=#333333 ctermfg=255 ctermbg=234
hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210
" }}}

" {{{ golang
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
let g:go_auto_type_info = 1
" autocmd BufWritePost,FileWritePost *.go silent execute 'GoMetaLinter' | cwindow

" GoMetaLinter invoke all possible linters (golint, vet, errcheck, deadcode, etc.) and put
" the result in the quickfix or location list.
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap gr :GoReferrers<CR>
au FileType go nmap gv <Plug>(go-def-vertical)
au FileType go nmap ds :GoDefStack<CR>
au FileType go nmap <Leader>d <Plug>(go-def-tab)
au FileType go nmap <leader>T <Plug>(go-test)
" }}}
"
" {{{ deoplete
let g:deoplete#enable_at_startup = 1
" }}}

" {{{ easymotion
let g:EasyMotion_smartcase = 1
nmap , <Plug>(easymotion-prefix)
nmap ; <Plug>(easymotion-lineanywhere)
map  s <Plug>(easymotion-sn)
map  s <Plug>(easymotion-tn)
" }}}

" {{{ Shougo/deoplete
" Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')
" Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')
"" tabnine
"call deoplete#custom#var('tabnine', {
"            \ 'line_limit': 100,
"            \ 'max_num_results': 3,
"            \ })
" }}}

" {{{ ultisnips
let g:UltiSnipsExpandTrigger="<c-l>" " 因为YouCompleteMe和ultisnips都映射了tab键引起冲突, 这儿更换掉ultisnips的映射
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" easymotion/vim-easymotion
hi link EasyMotionTarget2First  IncSearch
hi link EasyMotionTarget2Second IncSearch

match Error /\s\+$/
command! -range=% FixWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
