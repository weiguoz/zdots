vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- plugins
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require('config.lazy')

require('config.settings')
require('config.keymaps')
require('config.commands')

local init_vims = { "plugin_settings.vim" }
for _, f in ipairs(init_vims) do
    local fp = string.format("%s/zdots/dotvim/%s", os.getenv("HOME"), f)
    if vim.fn.filereadable(fp) then
        vim.cmd('source ' .. fp)
    end
end
