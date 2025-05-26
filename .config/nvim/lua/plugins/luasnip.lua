return {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },

    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node

        local get_username = function()
            return os.getenv("USER") or os.getenv("USERNAME") or "unknown"
        end

        local get_datetime = function()
            return os.date("%Y-%m-%d %H:%M")
        end

        -- add custom snippets
        ls.add_snippets("all", {
            s("todo", {
                f(function(_, _)
                    local comment = "//"
                    if vim.bo.filetype == "python" then
                        comment = "#"
                    end
                    return comment .. " TODO: "
                end, {}),
                i(1, "description"),
                t(" // @"),
                f(get_username),
                t(" "),
                f(get_datetime),
            }),
        })

        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
