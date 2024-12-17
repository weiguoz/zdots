return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- end of line
        delay = 200,
      },

      -- https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#keymaps
      on_attach = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', ':Gitsigns<CR>', { noremap = true, silent = true })

          local function map(mode, lhs, rhs, opts)
              opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end
          -- Navigation
          map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
          map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
      end,
    }
  end,
}
