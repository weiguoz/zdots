return {
    {
        "saghen/blink.cmp",
        version = "*",

        opts = {
            -- 代码编辑模式
            keymap = {
                preset = "default",

                ["<Tab>"] = {
                    "select_next",
                    "snippet_forward",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    "select_prev",
                    "snippet_backward",
                    "fallback",
                },

                ["<C-j>"] = {
                    "accept",
                    "fallback",
                },
            },

            -- 命令行模式
            cmdline = {
                enabled = true,

                completion = {
                    menu = {
                        auto_show = true,
                    },
                },

                sources = {
                    "cmdline",
                },

                keymap = {
                    preset = "cmdline",

                    ["<Tab>"] = {
                        "select_next",
                        "fallback",
                    },

                    ["<S-Tab>"] = {
                        "select_prev",
                        "fallback",
                    },
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },
    },
}
