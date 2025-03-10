-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
local all_themes = { 'edge:dark', 'edge:light',
  'caret:dark', 'caret:light',
  'everforest:dark', 'everforest:light',
  'Dayfox:light', 'Duskfox:dark', 'nightfox:dark', 'Nordfox:dark',
  'catppuccin-latte:light', 'catppuccin-frappe:dark', 'catppuccin-macchiato:dark', 'catppuccin-mocha:dark',
  'onedark', 'onedark_vivid', 'onedark_dark', 'onelight',
  'sonokai:dark', 'embark:dark', 'newpaper',
}

local function read_theme(store)
  local te = all_themes[1]
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

local function pick_theme(all_the, last_theme, step)
  local target = string.lower(last_theme)
  for i, theme in ipairs(all_the) do
    if string.lower(theme) == target then
      if step == 0 then
        return target -- return the last_theme if valid
      elseif step > 0 then
        return all_the[(i % #all_the) + step]
      else
        return i == 1 and all_the[#all_the] or all_the[i - 1]
      end
    end
  end
  return all_themes[1]
end

local theme_store = vim.fn.stdpath('data') .. '/theme_current.txt'

local function stepover_theme(all_the, last_the, step)
  local selected_theme = pick_theme(all_the, last_the, step)
  local cs_bg = vim.split(selected_theme, ':', { plain = true })
  vim.cmd('colorscheme ' .. cs_bg[1])
  if cs_bg[2] and cs_bg[2]:gsub("%s+", "") ~= "" then
    vim.o.background = cs_bg[2]
  end
  return selected_theme
end

local function stepover_theme_helper(step)
  local last_theme = read_theme(theme_store)
  local current_the = stepover_theme(all_themes, last_theme, step)
  print(current_the) -- print(vim.g.colors_name)
  return current_the
end

local function next_theme()
  local current_the = stepover_theme_helper(1)
  write_theme(theme_store, current_the)
end

local function prev_theme()
  local current_the = stepover_theme_helper(-1)
  write_theme(theme_store, current_the)
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
    vim.keymap.set('n', '<M-n>', next_theme, { noremap = true, silent = true })
    vim.keymap.set('n', '<M-p>', prev_theme, { noremap = true, silent = true })

    require("newpaper").setup({ style = "dark", keywords = "bold,italic" })

    -- local rd = math.floor((os.clock() * 1e7) % #colorschemes) + 1
    -- vim.cmd('colorscheme ' .. colorschemes[rd])
    -- vim.o.background = (os.clock() * 1e7 % 100 < 50) and 'dark' or 'light'
    -- require('onedarkpro').setup({
    --   styles = { comments = 'italic', keywords = 'bold,italic', functions = 'italic', conditionals = 'italic' },
    -- })

    -- placed in the end of function
    stepover_theme_helper(0)
  end,
}
