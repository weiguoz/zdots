local func = require("config.func")
-- switch the background color
vim.keymap.set("n", "<C-g>", ":lua ToggleBackground()<CR>", { silent = true, desc = "Toggle Background" })

-- 窗口内快速移动
vim.keymap.set("n", "<C-k>", ":call MoveRatioOfWindow('up', 33)<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":call MoveRatioOfWindow('down', 33)<CR>", { silent = true })
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

-- 缓冲区切换
vim.keymap.set("n", "b[", ":bp<CR>")
vim.keymap.set("n", "b]", ":bn<CR>")
vim.keymap.set("n", "<Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bnext<CR> ]], { silent = true })
vim.keymap.set("n", "<S-Tab>", [[ :if &modifiable && !&readonly && &modified <Bar> :write <Bar> endif <Bar> :bprev<CR> ]], { silent = true })

-- 放大缩小当前窗口
vim.keymap.set("n", "<leader>z", ":call ZoomToggle()<CR>", { silent = true })

-- bookmark 快捷键。https://github.com/LintaoAmons/bookmarks.nvim?tab=readme-ov-file#keymap
vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
vim.keymap.set({ "n", "v" }, "ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
vim.keymap.set({ "n", "v" }, "mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" })
