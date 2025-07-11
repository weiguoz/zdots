-- 'inkarkat/vim-mark' drop out at 20250203, because it has too many flaws
return {
    {
        'azabiong/vim-highlighter',
        event = 'VeryLazy',
        config = function()
            vim.g.HiKeywords = vim.fn.stdpath('data') .. '/highlighter_keywords' -- dir

            -- keymap https://github.com/azabiong/vim-highlighter/blob/8619d81479f0271179a59895785ecbae04a2da00/plugin/highlighter.vim#L22-L32
            -- ['nn', 'HiSet',   'f<CR>',  '+'    ], add
            -- ['xn', 'HiSet',   'f<CR>',  '+x'   ],
            -- ['nn', 'HiErase', 'f<BS>',  '-'    ], remove
            -- ['xn', 'HiErase', 'f<BS>',  '-x'   ],
            -- ['nn', 'HiClear', 'f<C-L>', 'clear'], clear
            -- ['nn', 'HiFind',  'f<Tab>', '/'    ], find
            -- ['xn', 'HiFind',  'f<Tab>', '/x'   ],
            -- ['nn', 'HiSetSL', 't<CR>',  '+%'   ], add single word
            -- ['xn', 'HiSetSL', 't<CR>',  '+x%'  ],
            vim.keymap.del('n', 'f<CR>')
            vim.keymap.del('n', 'f<BS>')
            vim.keymap.del('n', 'f<C-L>')
            vim.keymap.del('n', 'f<Tab>')
            vim.keymap.del('n', 't<CR>')

            vim.g.HiSetToggle = 1 -- add is enough, remove is not necessary
            vim.keymap.set('n', '<leader>ha', '<Cmd>Hi/+<CR>',
                { noremap = true, silent = true, desc = 'Highlight toggle, Hi/+<CR>' })
            vim.keymap.set('n', '<leader>hc', '<Cmd>Hi clear<CR>',
                { noremap = true, silent = true, desc = 'Highlight clear' })
            vim.keymap.set('n', '<leader>hs', '<Cmd>Hi/+%<CR>',
                { noremap = true, silent = true, desc = 'Highlight single word' })
            vim.keymap.set('n', '<leader>hn', '<Cmd>Hi><CR>',
                { noremap = true, silent = true, desc = 'Highlight next' })
            vim.keymap.set('n', '<leader>hp', '<Cmd>Hi<<CR>',
                { noremap = true, silent = true, desc = 'Highlight preview' })
            -- vim.keymap.set('n', '<leader>hx', '<Cmd>Hi/-<CR>', {noremap = true, silent = true, desc = 'Highlight remove'})
        end,
    }, {
    'RRethy/vim-illuminate', -- automatically highlighting the word under the cursor
    event = 'VeryLazy',
    config = function()
        require('illuminate').configure({ delay = 500 })
    end,
}
}
