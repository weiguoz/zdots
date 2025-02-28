return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'onsails/lspkind-nvim', -- for icons
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
        ['<C-f>'] = cmp.mapping.confirm({ select = true }),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif ls.jumpable(-1) then
            ls.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
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
        format = require('lspkind').cmp_format({
          with_text = true,
          maxwidth = 50,
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "| lsp",
              buffer = "| buf",
              path = "| Path",
              luasnip = "| 片段",
              cmdline = "| cmd",
            })[entry.source.name]
            return vim_item
          end
        })
      },
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
