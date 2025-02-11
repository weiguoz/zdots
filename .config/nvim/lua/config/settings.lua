-- vim.o.background = (os.clock() * 1e7 % 100 < 50) and "dark" or "light"
vim.opt.syntax = "enable"
vim.opt.termguicolors = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = true

-- autochdir = true takes very bad side-effect. "The file has been changed since reading it!!!" always pops up.
--- vim.opt.autochdir = true

vim.opt.cursorline = true
vim.opt.linebreak = true

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.mouse = vim.opt.mouse - "r"
-- vim.opt.mouse = "a"

vim.opt.foldmethod = "marker"

vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "ucs-bom", "cp936", "gbk", "gb2312", "gb18030" }

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore = { "*.o", "*.obj", "*~" }
--vim.opt.incsearch = true
--vim.opt.lazyredraw = false -- 执行宏时不重绘屏幕
--vim.opt.wildmenu = true -- 启用命令补全菜单
--vim.opt.wildmode = { "longest", "full" } -- 补全模式设置

-- {} () [] MatchParen
vim.cmd([[highlight MatchParen guibg=#85C664]])
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        if vim.fn.mode() == "n" then
            vim.cmd([[highlight MatchParen guibg=#85C664]])
        else
            vim.cmd([[highlight MatchParen guibg=NONE]])
        end
    end,
})

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
  pattern = { "c", "cpp", "go", "python", "lua", "rust", "sh" },
  callback = function()
    vim.opt.colorcolumn = "81"
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*.go", "*.sh", "*.py", "*.c", "*.cpp", "*.h", "*.hpp", "*.hxx", "*.hh" },
  callback = function()
    vim.cmd("lua SetTitle()")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("extraWhitespace", [[\s\+$\| \+\ze\t\+\|\t\+\zs \+]])
  end,
})
vim.api.nvim_set_hl(0, "extraWhitespace", { ctermbg = "red" })

local function init_undo(undo_dir)
    local d = vim.fn.expand(undo_dir)
    if vim.fn.isdirectory(d) == 0 then
        vim.fn.system({ "mkdir", "-p", d })
    end

    vim.opt.undodir = d
    vim.opt.undolevels = 500
    vim.opt.undofile = true
    vim.opt.colorcolumn = "+1"
end
init_undo("~/.local/share/nvim/undo")
