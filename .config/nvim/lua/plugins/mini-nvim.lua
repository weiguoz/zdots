return {
    {
        "echasnovski/mini.icons"
    },
    {
        -- 前边那条竖线
        "echasnovski/mini.indentscope",
        config = function()
            require('mini.indentscope').setup({
                draw = { delay = 1000 },
                mappings = {
                    goto_top = '[[',
                    goto_bottom = ']]',
                },
            })
        end
    }
}
