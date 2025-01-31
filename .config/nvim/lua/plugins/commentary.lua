return {
    "tpope/vim-commentary",
    lazy = false,
    config = function()
        local opt = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<C-_>", ":Commentary<CR>", opt)
        vim.api.nvim_set_keymap("v", "<C-_>", ":Commentary<CR>", opt)
        vim.api.nvim_set_keymap("i", "<C-_>", "<Esc>:Commentary<CR>", opt)
    end
}
