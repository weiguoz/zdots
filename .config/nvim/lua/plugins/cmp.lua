return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'onsails/lspkind-nvim', -- for icons
        'xzbdmw/colorful-menu.nvim', -- for menu
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local cmp = require('cmp')
        local ls = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                -- 关于 cmp.mapping.confirm 绑定的按键：c-y 离开食指太远，而 enter 与换行冲突. c-e 更好啊
                ['<C-e>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),

                -- ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
            },

            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            },

            completion = {
                autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
                completeopt = 'menu,menuone,noselect',
            },

            window = {
                -- completion = = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            formatting = {
                -- cmp tag/icon denotes the source of the completion
                format = function(entry, vim_item)
                    -- with lspkind: add prefix type for menu
                    local lspkind = require("lspkind")
                    -- local kind_icon = lspkind.symbolic(vim_item.kind, { with_text = false }) -- get the icon at first
                    vim_item = lspkind.cmp_format({
                        with_text = true,
                        maxwidth = 50,
                        before = function(new_entry, new_vim_item)
                            new_vim_item.menu = ({
                                nvim_lsp = '| lsp',
                                buffer = '| buf',
                                path = '| Path',
                                luasnip = '| 片段',
                                cmdline = '| cmd',
                            })[new_entry.source.name]
                            return new_vim_item
                        end
                    })(entry, vim_item)

                    -- with colorful-menu: add function args and return value for menu
                    -- https://github.com/xzbdmw/colorful-menu.nvim
                    local highlights_info = require("colorful-menu").cmp_highlights(entry)
                    if highlights_info ~= nil then
                        vim_item.abbr_hl_group = highlights_info.highlights
                        -- vim_item.abbr = kind_icon .. "  " .. highlights_info.text
                        vim_item.abbr = highlights_info.text
                    end

                    return vim_item
                end
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'path' },
                { name = 'cmdline' },
            },
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })
    end
}
