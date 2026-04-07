return {
  "dstein64/nvim-scrollview",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- 你可以按自己常用的侧边栏/浮窗 filetype 再补充
    excluded_filetypes = { "NvimTree", "neo-tree", "TelescopePrompt" },

    -- 只显示当前窗口的滚动条（多分屏时更清爽）
    current_only = true,

    -- 把可用的 sign group 都打开（至少 diagnostics/search/marks 会有；其他视你环境而定）
    signs_on_startup = { "all" },
  },
}
