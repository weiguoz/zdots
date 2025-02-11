local function read_theme(store)
  local te = 'desert'
  local f = io.open(store, 'r')
  if f then
    te = f:read('*l')
    f:close()
  end
  return te
end

local function write_theme(theme, store)
  local f = io.open(store, 'w')
  if f then
    f:write(theme)
    f:close()
  end
end

local function pick_theme(themes, last_theme, direction)
  for i, theme in ipairs(themes) do
    if string.lower(theme) == last_theme then
      if direction > 0 then
        return themes[(i % #themes) + 1]
      else
        return i == 1 and themes[#themes] or themes[i - 1]
      end
    end
  end
  return 'desert'
end

local colorscheme_store = vim.fn.stdpath('data') .. '/colorscheme_current.txt'

local function switch_theme(direction)
  local colorschemes = { 'edge', 'Dayfox', 'sonokai', 'Duskfox', 'onedark', 'everforest', 'nightfox', 'Dawnfox', 'Nordfox', 'caret', 'embark' } -- list of colorschemes
  local current_color = string.lower(vim.g.colors_name)
  local selected = pick_theme(colorschemes, current_color, direction)
  vim.cmd('colorscheme ' .. selected)
  write_theme(selected, colorscheme_store)
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
     'sainnhe/sonokai',
     'sainnhe/everforest',
     'olimorris/onedarkpro.nvim',
     'EdenEast/nightfox.nvim',
     'projekt0n/caret.nvim',
     'embark-theme/vim',
   },

  priority = 1000,
  config = function()
    -- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
    vim.cmd('colorscheme ' .. read_theme(colorscheme_store))
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
