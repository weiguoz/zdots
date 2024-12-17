-- 显示与界面设置
vim.cmd("colorscheme edge")
vim.o.background = (os.clock() * 1e6 % 100 < 50) and "dark" or "light"
vim.opt.syntax = "enable"
-- vim.opt.termguicolors = true  -- 256色支持，不需要
vim.opt.ruler = true  -- 显示光标位置
vim.opt.showcmd = true
vim.opt.showmatch = true  -- 高亮匹配括号
vim.opt.showmode = true

-- autochdir = true takes very bad side-effect. "The file has been changed since reading it!!!" always pops up.
--- vim.opt.autochdir = true

-- 光标和折行
vim.opt.cursorline = true
vim.opt.linebreak = true

-- 缩进设置
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

-- 显示行号与禁用鼠标右键
vim.opt.number = true
vim.opt.mouse = vim.opt.mouse - "r"
-- vim.opt.mouse = "a"  -- 启用鼠标全部功能（根据需要）

-- 折叠设置
vim.opt.foldmethod = "marker"

-- 编码设置
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "ucs-bom", "cp936", "gbk", "gb2312", "gb18030" }

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore = { "*.o", "*.obj", "*~" }
--vim.opt.incsearch = true
--vim.opt.lazyredraw = false -- 执行宏时不重绘屏幕
--vim.opt.wildmenu = true -- 启用命令补全菜单
--vim.opt.wildmode = { "longest", "full" } -- 补全模式设置

-- 针对特定文件禁用备份
vim.api.nvim_create_autocmd("BufWrite", {
  pattern = "/private/etc/pw.*",
  callback = function()
    vim.opt.writebackup = false
    -- vim.opt.backup = false
  end,
})

-- 针对特定文件类型设置代码列限制
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "go", "python" },
  callback = function()
    vim.opt.colorcolumn = "81"
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*.go", "*.sh", "*.py", "*.c", "*.cpp", "*.h", "*.hpp", "*.hxx", "*.hh" },
  callback = function()
    vim.cmd("call SetTitle()")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
  end,
})

-- 定义高亮组 ExtraWhitespace
-- vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "extraWhitespace", { ctermbg = "red" })
-- 设置自动命令
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("extraWhitespace", [[\s\+$\| \+\ze\t\+\|\t\+\zs \+]])
  end,
})

local function initUndo(undo_dir)
    local d = vim.fn.expand(undo_dir)
    if vim.fn.isdirectory(d) == 0 then
        vim.fn.system({ "mkdir", "-p", d })
    end

    vim.opt.undodir = d
    vim.opt.undolevels = 500
    vim.opt.undofile = true
    vim.opt.colorcolumn = "+1"
end
initUndo("~/.local/share/nvim/undo")
