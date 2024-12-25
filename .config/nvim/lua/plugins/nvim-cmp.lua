return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-l>'] = cmp.mapping.confirm({ select = true }),
        -- ['<C-Space>'] = cmp.mapping.complete(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
      completion = {
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
        completeopt = 'menu,menuone,noinsert',
      },
      window = {
        -- completion = = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
