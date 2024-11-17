vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- plugins
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require('config.lazy')

require('config.settings')
require('config.keymaps')
require('config.autocmds')

local init_vims = { "functions.vim", "plugin_settings.vim" }
for _, f in ipairs(init_vims) do
    local init_vim_path = string.format("%s/zdots/dotvim/%s", os.getenv("HOME"), f)
    if vim.fn.filereadable(init_vim_path) then
        vim.cmd('source ' .. init_vim_path)
    end
end
