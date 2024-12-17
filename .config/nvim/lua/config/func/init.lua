function toggle_background()
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
    vim.cmd("syntax on")
end
