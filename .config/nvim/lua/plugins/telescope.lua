function GitBcommitsOnCursor()
  local file = vim.fn.expand('%')
  local line = vim.api.nvim_win_get_cursor(0)[1]
  require('telescope.builtin').git_bcommits_range({
    from = line,
    to = line,
    file = file,
    previewer = true,
    shorten_path = true,
    attach_mappings = function(_, map) -- _ = prompt_bufnr
      -- disable enter key to step into commit
      local actions = require('telescope.actions')
      map('i', '<CR>', actions.close)
      map('n', '<CR>', actions.close)
      return true
    end,
  })
end

vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua pcall(GitBcommitsOnCursor)<CR>', { noremap = true, silent = true })

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
        mappings = {
          -- close on single escape or double escape
          i = { ['<Esc>'] = require('telescope.actions').close },

          -- n = { ['<Esc>'] = require('telescope.actions').close },
        },
      },
    }

    local opt = { noremap = true, silent = true }
    vim.keymap.set('n', 't', '<cmd>Telescope<cr>', opt)
    vim.keymap.set('n', 'c', '<cmd>Telescope commands<cr>', opt)
    vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>', opt)
    -- vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', opt) -- instead by 'nvim-telescope/telescope-file-browser.nvim'
    vim.keymap.set("n", "s", function()
      local word = vim.fn.expand("<cword>")
      vim.cmd("Telescope live_grep default_text=" .. word)
    end, opt)

    vim.keymap.set("n", "<leader>t", function()
      vim.fn.feedkeys(":Telescope lsp_document_symbols symbols=function,method,variable", "nt")
    end, { desc = "Feed Telescope command" })
  end,
}
