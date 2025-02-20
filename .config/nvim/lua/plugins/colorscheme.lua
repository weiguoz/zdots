local function split(input, sep)
  local t = {}
  for str in string.gmatch(input, "([^" .. sep .. "]+)") do
      table.insert(t, str)
  end
  return t
end

local function read_theme(store)
  local te = 'desert:dark'
  local f = io.open(store, 'r')
  if f then
    te = f:read('*l')
    f:close()
  end
  return te
end

local function write_theme(store, theme)
  local f = io.open(store, 'w')
  if f then
    f:write(theme)
    f:close()
  end
end

local function pick_theme(themes, last_theme, direction)
  local target = string.lower(last_theme)
  for i, theme in ipairs(themes) do
    if string.lower(theme) == target then
      if direction > 0 then
        return themes[(i % #themes) + 1]
      else
        return i == 1 and themes[#themes] or themes[i - 1]
      end
    end
  end
  return 'desert:dark'
end

local theme_store = vim.fn.stdpath('data') .. '/theme_current.txt'

local function switch_theme(direction)
  local themes = { 'edge:dark', 'edge:light',
        'caret:dark', 'caret:light',
        'everforest:dark', 'everforest:light',
        'Dayfox:light', 'Duskfox:dark', 'nightfox:dark', 'Nordfox:dark',
        'catppuccin-latte:light', 'catppuccin-frappe:dark', 'catppuccin-macchiato:dark', 'catppuccin-mocha:dark',
        'sonokai:dark', 'onedark:dark', 'embark:dark', 'newpaper:dark',
  } -- list of colorschemes
  local current_theme = read_theme(theme_store)
  local selected_theme = pick_theme(themes, current_theme, direction)
  local cs_bg = split(selected_theme, ':')
  vim.cmd('colorscheme ' .. cs_bg[1])
  vim.o.background = cs_bg[2]
  write_theme(theme_store, selected_theme)
end

local function next_theme()
    switch_theme(1)
    print(vim.g.colors_name)
end

local function prev_theme()
    switch_theme(-1)
    print(vim.g.colors_name)
end

return {
  'sainnhe/edge',

   dependencies = { -- fake dependencies
    'projekt0n/caret.nvim',
    'sainnhe/everforest',
    'EdenEast/nightfox.nvim',
    'catppuccin/nvim',
    'sainnhe/sonokai',
    'olimorris/onedarkpro.nvim',
    'embark-theme/vim',
    'yorik1984/newpaper.nvim',
   },

  priority = 1000,
  config = function()
    -- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
    local cs_bg = split(read_theme(theme_store), ':')
    vim.cmd('colorscheme ' .. cs_bg[1])
    vim.o.background = cs_bg[2]

    vim.keymap.set('n', '<M-n>', next_theme, { noremap = true, silent = true })
    vim.keymap.set('n', '<M-p>', prev_theme, { noremap = true, silent = true })

    -- local rd = math.floor((os.clock() * 1e7) % #colorschemes) + 1
    -- vim.cmd('colorscheme ' .. colorschemes[rd])
    -- vim.o.background = (os.clock() * 1e7 % 100 < 50) and 'dark' or 'light'
    -- require('onedarkpro').setup({
    --   styles = { comments = 'italic', keywords = 'bold,italic', functions = 'italic', conditionals = 'italic' },
    -- })
  end,
}
