return {
  "echasnovski/mini.indentscope",
  config = function ()
    require('mini.indentscope').setup({
      draw = {
        delay = 800,
      },
      mappings = {
        goto_top = '[[',
        goto_bottom = ']]',
      },
    })
  end
}
