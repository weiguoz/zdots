-- 'inkarkat/vim-mark' drop out at 20250203, because it has too many flaws
return {
    'azabiong/vim-highlighter',
    dependencies = { -- fake dependencies
        'RRethy/vim-illuminate', -- automatically highlighting the word under the cursor
    },
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
        vim.g.HiSetToggle = 1 -- add is enough, remove is not necessary
        -- local opts = { noremap = true, silent = true }
        -- vim.keymap.set('n', '<leader>m', '<Cmd>Hi/+%<CR>', opts)
        vim.keymap.del('n', 't<CR>')
        vim.keymap.del('n', 'f<BS>')

        require'illuminate'.configure({ delay = 500 })
    end,
}
