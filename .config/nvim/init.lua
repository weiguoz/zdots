require('config.options')  -- 选项配置

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
-- 配置 lua/config/lazy.lua
require('config.lazy')

-- 设置基础选项
require('config.keymaps')
-- require('config.autocmds')

local init_vims = { "functions.vim", "vimrc.vim", "plugin_settings.vim" }
for _, f in ipairs(init_vims) do
    local init_vim_path = string.format("%s/zdots/dotvim/%s", os.getenv("HOME"), f)
    if vim.fn.filereadable(init_vim_path) then
        vim.cmd('source ' .. init_vim_path)
    end
end
