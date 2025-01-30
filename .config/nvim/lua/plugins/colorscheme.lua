local function read_last_theme(store)
  local f = io.open(store, 'r')
  if f then
    local last_theme = f:read('*l')
    f:close()
    return last_theme
  end
  return nil
end

local function write_theme(theme, store)
  local f = io.open(store, 'w')
  if f then
    f:write(theme)
    f:close()
  end
end

local function select_next_theme(themes, store)
  local last_theme = read_last_theme(store)
  local next_index = 1
  for i, theme in ipairs(themes) do
    if theme == last_theme then
      next_index = (i % #themes) + 1
      break
    end
  end
  return themes[next_index]
end

local colorscheme_store = vim.fn.stdpath('data') .. '/colorscheme_current.txt'

local function switch_to_next_theme()
  local colorschemes = { 'edge', 'Dayfox', 'sonokai', 'Duskfox', 'onedark', 'everforest', 'nightfox', 'Dawnfox', 'Nordfox' } -- list of colorschemes

  local selected = select_next_theme(colorschemes, colorscheme_store)
  vim.cmd('colorscheme ' .. selected)
  write_theme(selected, colorscheme_store)
end

return {
  'sainnhe/edge',

   dependencies = { -- fake dependencies
     'sainnhe/sonokai',
     'sainnhe/everforest',
     'olimorris/onedarkpro.nvim',
     'EdenEast/nightfox.nvim',
   },

  priority = 1000,
  config = function()
    -- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
    local last_theme = read_last_theme(colorscheme_store)
    vim.cmd('colorscheme ' .. last_theme)
    vim.keymap.set('n', '<c-g>', switch_to_next_theme, { noremap = true, silent = true })

    -- local rd = math.floor((os.clock() * 1e7) % #colorschemes) + 1
    -- vim.cmd('colorscheme ' .. colorschemes[rd])
    -- vim.o.background = (os.clock() * 1e7 % 100 < 50) and 'dark' or 'light'
    -- require('onedarkpro').setup({
    --   styles = { comments = 'italic', keywords = 'bold,italic', functions = 'italic', conditionals = 'italic' },
    -- })
  end,
}
