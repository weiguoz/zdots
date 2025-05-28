return {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },

    config = function()
        local lsnp = require("luasnip")
        local s = lsnp.snippet
        local t = lsnp.text_node
        local i = lsnp.insert_node
        local f = lsnp.function_node

        local get_username = function()
            return os.getenv("USER") or os.getenv("USERNAME") or "unknown"
        end

        local get_datetime = function()
            return os.date("%Y-%m-%d %H:%M")
        end

        -- add custom snippets
        lsnp.add_snippets("all", {
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

        vim.keymap.set({ "i" }, "<C-k>", function() lsnp.expand() end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-l>", function() lsnp.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-h>", function() lsnp.jump(-1) end, { silent = true })

        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
