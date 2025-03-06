vim.opt.guicursor = {
  "n-v-c:block-blinkwait300-blinkon200-blinkoff150",
  "i:ver15-blinkwait200-blinkon150-blinkoff100",
}

return {
  "sphamba/smear-cursor.nvim",

  -- never delete opts, event it's empty
  opts = {
      cursor_color = "#d3cdc3",
  },
}
