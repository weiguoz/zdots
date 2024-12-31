require("config.func")
-- switch the background color
vim.keymap.set("n", "<C-g>", ":lua ToggleBackground()<CR>", { silent = true, desc = "toggle background" })

-- 窗口内快速移动
vim.keymap.set("n", "<C-u>", ":lua MoveRatioOfWindow('up', 33)<CR>", { silent = true })
vim.keymap.set("n", "<C-d>", ":lua MoveRatioOfWindow('down', 33)<CR>", { silent = true })
-- nnoremap <c-m> :call cursor(0, len(getline('.'))/2)<CR>

-- 行首行尾快捷键
vim.keymap.set("n", "<C-a>", "0")
vim.keymap.set("n", "<C-e>", "$")
vim.keymap.set("i", "<C-a>", "<Esc>I")
vim.keymap.set("i", "<C-e>", "<Esc>A")

-- insert 模式快速退出
vim.keymap.set("i", "jk", "<Esc>l")
vim.keymap.set("i", "kj", "<Esc>l")

-- 保存和退出
vim.keymap.set("n", "zz", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = true })

-- insert 模式的方向键映射
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-w>", "<S-Right>")
vim.keymap.set("i", "<C-b>", "<S-Left>")
vim.keymap.set("i", "<C-o>", "<Esc>o")
vim.keymap.set("i", "<C-d>", "<Esc>dd")

-- 缓冲区切换
-- vim.keymap.set("n", "<C-[>", ":bp<CR>")
-- vim.keymap.set("n", "<C-]>", ":bn<CR>")
-- vim.keymap.set("n", "<Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bprev<CR> ]], { silent = true })
-- vim.keymap.set("n", "<S-Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bnext<CR> ]], { silent = true })

vim.keymap.set("n", "<leader>z", ":lua ZoomWinToggle()<CR>", { silent = true })
