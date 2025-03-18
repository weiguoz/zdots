-- auto commands

-- user commands
vim.api.nvim_create_user_command(
    "TrimWhitespace",
    function()
        local saved_search = vim.fn.getreg("/")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setreg("/", saved_search)
    end,
    { range = "%" }  -- 允许命令在整个缓冲区范围内执行
)
