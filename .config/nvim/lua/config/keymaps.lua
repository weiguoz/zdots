require("config.func")

-- 翻页
-- 禁用 C-f 和 C-b。因为后者和 tmux 的 prefix 冲突，在 wezterm 中很难解决
-- 用 C-d 和 C-u 来模拟翻页
vim.keymap.set("n", "<C-f>", "<Nop>")
vim.keymap.set("n", "<C-b>", "<Nop>")
vim.keymap.set("n", "<C-d>", "<C-f>")
vim.keymap.set("n", "<C-u>", "<C-b>")

-- head and tail
vim.keymap.set("n", "<C-a>", "0")
vim.keymap.set("n", "<C-e>", "$")
vim.keymap.set("i", "<C-a>", "<Esc>I")
vim.keymap.set("i", "<C-e>", "<Esc>A")

-- quit insert
vim.keymap.set("i", "jj", "<Esc>l")

vim.keymap.set("n", "<leader>q", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = true })

-- move in the insert mode
vim.keymap.set("i", "<M-j>", "<Down>")
vim.keymap.set("i", "<M-k>", "<Up>")
vim.keymap.set("i", "<M-h>", "<Left>")
vim.keymap.set("i", "<M-l>", "<Right>")
vim.keymap.set("i", "<M-w>", "<S-Right>")
vim.keymap.set("i", "<M-b>", "<S-Left>")
vim.keymap.set("i", "<M-d>", "<Esc>dd")
vim.keymap.set("i", "<M-o>", "<Esc>o")

-- split current window
vim.keymap.set("n", "gv", ":vsplit<CR>", { silent = true })

-- switch in the buffer
-- vim.keymap.set("n", "<C-[>", ":bp<CR>")
-- vim.keymap.set("n", "<C-]>", ":bn<CR>")
-- vim.keymap.set("n", "<Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bprev<CR> ]], { silent = true })
-- vim.keymap.set("n", "<S-Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bnext<CR> ]], { silent = true })

vim.keymap.set("n", "<leader>z", ":lua ZoomWinToggle()<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":only<CR>", { silent = true })

-- search cursor word
-- vim.keymap.set('n', '/', function()
--   local word = vim.fn.expand('<cword>')
--   vim.fn.setreg('/', word)
--   vim.api.nvim_feedkeys('/' .. word, 'n', false)
-- end, { noremap = true, silent = true })
