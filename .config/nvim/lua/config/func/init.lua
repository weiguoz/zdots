-- switch the background color
-- vim.keymap.set("n", "<C-g>", ":lua ToggleBackground()<CR>", { silent = true, desc = "toggle background" })
function ToggleBackground()
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
    vim.cmd("syntax on")
end

-- move quickly
-- nnoremap <c-m> :call cursor(0, len(getline('.'))/2)<CR>
-- vim.keymap.set("n", "<C-k>", ":lua MoveRatioOfWindow('up', 33)<CR>", { silent = true })
-- vim.keymap.set("n", "<C-j>", ":lua MoveRatioOfWindow('down', 33)<CR>", { silent = true })
function MoveRatioOfWindow(move, ratio)
    if ratio < 0 or ratio > 100 then
        print("Invalid ratio, must be between 0 and 100")
        return
    end

    local key = "j"
    if move == 'up' then
        key = "k"
    end

    local height = vim.fn.winheight(0)
    local move_count = math.floor(height * ratio / 100)
    vim.cmd('normal! ' .. move_count .. key)
end

function ZoomWinToggle()
    if vim.g.zoomed then
        vim.cmd(vim.g.zoom_winrestcmd)
    else
        vim.g.zoom_winrestcmd = vim.fn.winrestcmd()
        vim.cmd("resize")
        vim.cmd("vertical resize")
    end
    vim.g.zoomed = not vim.g.zoomed
end

function SetTitle()
    local ft = vim.bo.filetype

    if ft == 'sh' or ft == 'python' then
        if ft == 'sh' then
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/bin/sh" })
        else
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/usr/bin/python" })
        end

        vim.api.nvim_buf_set_lines(0, 1, 1, false,
            { "#****************************************************************#" })
        vim.api.nvim_buf_set_lines(0, 2, 2, false,
            { "# " .. vim.fn.expand("$USER") .. " created " .. vim.fn.expand("%") .. " at " .. vim.fn.strftime("%F %R") })
        vim.api.nvim_buf_set_lines(0, 3, 3, false, { "# Function:" })
        vim.api.nvim_buf_set_lines(0, 4, 4, false,
            { "#***************************************************************#" })
        vim.api.nvim_buf_set_lines(0, 5, 5, false, { "" })
    elseif ft == 'c' or ft == 'cpp' then
        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "/**" })
        vim.api.nvim_buf_set_lines(0, 1, 1, false,
            { " * " .. vim.fn.expand("$USER") .. " created " .. vim.fn.expand("%") .. " at " .. vim.fn.strftime("%F %R") })
        vim.api.nvim_buf_set_lines(0, 2, 2, false, { " *" })
        vim.api.nvim_buf_set_lines(0, 3, 3, false, { " * Description:" })
        vim.api.nvim_buf_set_lines(0, 4, 4, false, { " */" })
        vim.api.nvim_buf_set_lines(0, 5, 5, false, { "" })

        if vim.fn.expand('%:e'):match('h(pp|h|\\+\\+|xx)?$') then
            -- Do nothing
        else
            if ft == 'c' then
                vim.api.nvim_buf_set_lines(0, 6, 6, false, { "#include <stdio.h>" })
            else
                vim.api.nvim_buf_set_lines(0, 6, 6, false, { "#include <cstdio>" })
            end
            vim.api.nvim_buf_set_lines(0, 7, 7, false, { "" })
            vim.api.nvim_buf_set_lines(0, 8, 8, false, { "int main() {" })
            vim.api.nvim_buf_set_lines(0, 9, 9, false, { "    printf(\"Hello\\n\");" })
            vim.api.nvim_buf_set_lines(0, 10, 10, false, { "    return 0;" })
            vim.api.nvim_buf_set_lines(0, 11, 11, false, { "}" })
        end
    elseif ft == 'go' then
        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "package main" })
        vim.api.nvim_buf_set_lines(0, 1, 1, false, { "" })
        vim.api.nvim_buf_set_lines(0, 2, 2, false, { "import \"fmt\"" })
        vim.api.nvim_buf_set_lines(0, 3, 3, false, { "" })
        vim.api.nvim_buf_set_lines(0, 4, 4, false, { "func main() {" })
        vim.api.nvim_buf_set_lines(0, 5, 5, false, { "    fmt.Println(\"Hello\")" })
        vim.api.nvim_buf_set_lines(0, 6, 6, false, { "}" })
    end
end
