require("config.func")

-- head and tail
vim.keymap.set("n", "<C-a>", "0")
vim.keymap.set("n", "<C-e>", "$")
vim.keymap.set("i", "<C-a>", "<Esc>I")
vim.keymap.set("i", "<C-e>", "<Esc>A")

-- quit insert
vim.keymap.set("i", "jk", "<Esc>l")
vim.keymap.set("i", "kj", "<Esc>l")

-- save, quit
vim.keymap.set("n", "zz", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = true })

-- move in the insert mode
vim.keymap.set("i", "<C-w>", "<S-Right>")
vim.keymap.set("i", "<C-b>", "<S-Left>")
vim.keymap.set("i", "<C-o>", "<Esc>o")
vim.keymap.set("i", "<C-d>", "<Esc>dd")

-- split current window
vim.keymap.set("n", "gv", ":vsplit<CR>", { silent = true })

-- switch in the buffer
-- vim.keymap.set("n", "<C-[>", ":bp<CR>")
-- vim.keymap.set("n", "<C-]>", ":bn<CR>")
-- vim.keymap.set("n", "<Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bprev<CR> ]], { silent = true })
-- vim.keymap.set("n", "<S-Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bnext<CR> ]], { silent = true })

vim.keymap.set("n", "<leader>z", ":lua ZoomWinToggle()<CR>", { silent = true })
