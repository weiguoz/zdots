-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
local all_themes = { 'edge:dark', 'edge:light',
    'Dayfox:light', 'Duskfox:dark', 'nightfox:dark', 'Nordfox:dark',
    'catppuccin-latte:light', 'catppuccin-frappe:dark', 'catppuccin-macchiato:dark', 'catppuccin-mocha:dark',
    'embark:dark',
    'aurora:dark',
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

-- ~/.local/share/nvim/theme_current.txt
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

vim.keymap.set('n', '<M-n>', next_theme, { noremap = true, silent = true })
vim.keymap.set('n', '<M-p>', prev_theme, { noremap = true, silent = true })
-- local rd = math.floor((os.clock() * 1e7) % #colorschemes) + 1
-- vim.cmd('colorscheme ' .. colorschemes[rd])
-- vim.o.background = (os.clock() * 1e7 % 100 < 50) and 'dark' or 'light'

-- bold, italic, underline, strikethrough, standout, reverse, undercurl, none
local my_styles = {
    comments = { "italic" },
    keywords = { "italic" },
    functions = { "bold" },
    conditionals = { "italic" },
    loops = { "underline" },
    types = { "bold" },
    variables = {},
    numbers = {},
    strings = {},
    operators = {},
}

local function set_naive_italic()
    vim.cmd [[
    highlight Keyword gui=italic
    highlight Conditional gui=italic
    highlight Repeat gui=italic
    highlight Function gui=italic
    highlight Statement gui=italic
  ]]
end

return {
    {
        'sainnhe/edge',
        config = function()
            vim.g.edge_enable_italic = 1
            vim.defer_fn(set_naive_italic, 50)
            stepover_theme_helper(0) -- MUST set `lazy = false` as default
        end,
    },
    {
        'EdenEast/nightfox.nvim',
        lazy = true,
        config = function()
            require('nightfox').setup({ options = { styles = { comments = 'italic', keywords = 'bold,italic', functions = 'italic', types = '' } } })
        end,
    },
    {
        'catppuccin/nvim',
        lazy = true,
        name = 'catppuccin',
        config = function()
            require("catppuccin").setup({ styles = my_styles })
        end,
    },
    {
        'embark-theme/vim',
        lazy = true,
        name = 'embark',
        config = function()
            vim.g.embark_terminal_italics = 1
            vim.defer_fn(set_naive_italic, 50)
        end
    },
    {
        'ray-x/aurora',
        lazy = true,
        init = function()
            vim.g.aurora_italic = 1
            vim.g.aurora_transparent = 1
            vim.g.aurora_bold = 1
        end,
    }
}
