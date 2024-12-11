return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        enabled = true,  -- if you want to enable the plugin
        message_template = " <<sha>> • <date> @<author>: <summary>", -- template for the blame message, check the Message template section for more options
        date_format = "%y-%m-%d %H:%M", -- template for the date, check Date format section for more options
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
}
