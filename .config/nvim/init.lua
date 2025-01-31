vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- plugins
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require('config.lazy')

require('config.settings')
require('config.keymaps')
require('config.commands')
