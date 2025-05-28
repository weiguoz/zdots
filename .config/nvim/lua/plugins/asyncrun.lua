return {
    "skywind3000/asyncrun.vim",
    lazy = false,
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>ar", ":AsyncRun<Space>",
            { noremap = true, silent = false, desc = "AsyncRun run" })
        vim.api.nvim_set_keymap("n", "<leader>aq", ":call asyncrun#quickfix_toggle(6)<CR>",
            { noremap = true, silent = true, desc = "AsyncRun quickfix" })

        vim.g.asyncrun_open = 8 -- open quickfix window automatically when AsyncRun is executed

        vim.cmd([[
      augroup AsyncRunKeymap
      autocmd!
      autocmd FileType cpp nnoremap <silent> run :AsyncRun clang++ -DDBG -Wall -Wextra -Werror -Wshadow -g -std=c++20 -o %< % && (./%< ; rm -rf %< %<.dSYM)<CR>
      autocmd FileType c nnoremap <silent> run :AsyncRun clang -DDBG -Wall -Wextra -Werror -Wshadow -g -o %< % && (./%< ; rm -rf %< %<.dSYM)<CR>
      autocmd FileType go nnoremap <silent> run :AsyncRun go run %<CR>
      augroup END
      ]])
    end
}

-- {{{ just for reference
-- " complie a single cpp/c file & run
-- " func! CompileAndRun()
-- "     let opt = "-DDBG -Wall -Wextra -Werror -Wshadow -g" " -Wconversion
-- "     if (&filetype == "c")
-- "         exec "!clang ".opt." -o %< % && (./%< ; rm -rf %< %<.dSYM)"
-- "     elseif (&filetype == "cpp")
-- "         silent exec "!clang++ ".opt." -std=c++20 -o %< % && (./%< ; rm -rf %< %<.dSYM)"
-- "     elseif (&filetype == "go")
-- "         exec "!go run %"
-- "     else
-- "         echohl WarningMsg | echo &filetype" is not a kind of runnable filetype" | echohl None
-- "     endif
-- "     " if !v:shell_error
-- "     "   ...
-- "     " endif
-- " endfunc
-- "
-- " if !has('nvim') " placed in .vimrc
-- "     au FileType cpp,c,go command! -nargs=0 -bang Run call CompileAndRun()
-- "     au FileType cpp,c,go nnoremap <silent> run :exec 'Run'<CR>
-- " endif
-- }}}
