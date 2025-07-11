function GitBcommitsOnCursor()
    local file = vim.fn.expand('%')
    local line = vim.api.nvim_win_get_cursor(0)[1]
    require('telescope.builtin').git_bcommits_range({
        from = line,
        to = line,
        file = file,
        previewer = true,
        shorten_path = true,
        attach_mappings = function(_, map) -- _ = prompt_bufnr
            -- disable enter key to step into commit
            local actions = require('telescope.actions')
            map('i', '<CR>', actions.close)
            map('n', '<CR>', actions.close)
            return true
        end,
    })
end

vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua pcall(GitBcommitsOnCursor)<CR>',
    { noremap = true, silent = true, desc = "Git commits on cursor" })

return {
    'nvim-telescope/telescope.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'folke/trouble.nvim',
        'LukasPietzschmann/telescope-tabs',
        'benfowler/telescope-luasnip.nvim',
    },
    -- 其实是 telescope-tabs/telescope-luasnip 依赖 telescope.nvim

    config = function()
        local tlsc = require("telescope")

        tlsc.load_extension('telescope-tabs')
        tlsc.load_extension('luasnip')

        local open_with_trouble = require("trouble.sources.telescope").open
        tlsc.setup {
            defaults = {
                file_ignore_patterns = { "node_modules", ".git" },
                mappings = {
                    -- close on single escape or double escape
                    i = {
                        ["<Esc>"] = require("telescope.actions").close,
                        ["<c-t>"] = open_with_trouble,
                    },
                    n = { ["<c-t>"] = open_with_trouble },
                },
                -- layout
                layout_strategy = 'horizontal',                                     -- horizontal,  vertical, center, cursor
                layout_config = {
                    width = 0.8, height = 0.9,                                      -- top bottom
                    horizontal = { prompt_position = "top", preview_width = 0.65 }, -- "bottom" or "top"
                    vertical = { mirror = true, preview_height = 0.7 },
                },
                sorting_strategy = "ascending",
                winblend = 7,
            },
        }

        vim.keymap.set("n", "<leader>l", function()
            tlsc.extensions.luasnip.luasnip()
        end, { desc = "Snippets" })

        local opt = { noremap = true, silent = true }
        vim.keymap.set('n', 't', '<cmd>Telescope<cr>', opt)
        vim.keymap.set('n', 'c', '<cmd>Telescope commands<cr>', opt)

        -- search the cursor word, without filter
        vim.keymap.set("n", "s", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("Telescope live_grep default_text=" .. word)
            -- vim.cmd("Telescope live_grep default_text=" .. word .. " grep_open_files=true")
        end, { noremap = true, silent = true, desc = "Telescope: grep" })

        -- search the fixed cursor word, with file name filter
        vim.keymap.set("n", "<leader>s", function()
            vim.cmd("Telescope grep_string")
        end, { noremap = true, silent = true, desc = "Telescope: search(grep)" })

        vim.keymap.set("n", "<leader>*", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("Telescope current_buffer_fuzzy_find default_text=" .. word)
        end, { noremap = true, silent = true, desc = "Telescope: search(fuzzy) in the buffer" })
        -- grep end

        vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', opt)
        vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>', opt)
        vim.keymap.set('n', '<leader>t', '<cmd>Telescope telescope-tabs list_tabs<cr>', opt) -- with the help of plugin `telescope-tabs`

        vim.keymap.set("n", "<leader>v", function()
            vim.fn.feedkeys(":Telescope lsp_document_symbols symbols=function,method,variable", "nt")
        end, { desc = "Telescope: list symbols in the buffers" })
    end,
}
-- NOTE，在prompt窗口中，
-- c-w 删除前一个单词
-- c-h 删除前一个字符
-- c-d/u preview 窗口翻半页

-- fzf's replacement is telescope
-- " {{{ fzf buffers <- so I remove the buftabline from my plugins
-- " fzf quicks
-- let g:fzf_buffers_jump = 1
-- let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
--
-- function! s:list_buffers()
--     redir => list
--     silent ls
--     redir END
--     return split(list, "\n")
-- endfunction
--
-- function! s:delete_buffers(lines)
--     execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
-- endfunction
--
-- command! BD call fzf#run(fzf#wrap({
--             \ 'source': s:list_buffers(),
--             \ 'sink*': { lines -> s:delete_buffers(lines) },
--             \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept' }))
--
-- let g:fzf_action = {
--   \ 'ctrl-t': 'tab split',
--   \ 'ctrl-v': 'vsplit' }
--
-- function! RGOptFun(arg, fullscreen)
--     let tokens  = split(a:arg)
--     let opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
--     let query = join(filter(copy(tokens), 'v:val !~ "^-"'))
--
--     let command_fmt = 'rg --column --no-heading --color=always --smart-case '.opts.' -- %s || true'
--     let initial_command = printf(command_fmt, shellescape(query))
--     let reload_command = printf(command_fmt, '{q}')
--     let spec = {'options': ['--phony', '--query', query, '--bind', 'change:reload:'.reload_command, '--preview-window=right:70%']}
--     call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
-- endfunction
-- noremap <silent><leader>s :call RGOptFun(expand('<cword>'), 0)<CR>
-- " Customized Rg, support options like:
-- " :Rg -C2 -tgo os.remove<enter>
-- " :Rg -C2 -tgo <enter>, then> os.remove
-- " :Rg os.remove<enter>
-- command! -nargs=* -bang Rg call RGOptFun(<q-args>, <bang>0)
-- " }}}
