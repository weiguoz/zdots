return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require('dap')
    local dapui = require("dapui")

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    dap.adapters.go = {
      type = 'server',
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "--listen=127.0.0.1:${port}", "--headless=true", "--api-version=2" },
      }
    }

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Launch file',
        request = 'launch',
        program = '${file}',
      },
      {
        type = 'go',
        name = 'Debug package',
        request = 'launch',
        program = '${workspaceFolder}',
      },
    }

    local mapkey = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    mapkey('n', '<F5>', ':lua require"dap".continue()<CR>', opts)         -- 继续执行
    mapkey('n', '<F9>', ':lua require"dap".toggle_breakpoint()<CR>', opts) -- 设置/取消断点
    mapkey('n', '<F10>', ':lua require"dap".step_over()<CR>', opts)        -- 跳过
    mapkey('n', '<F11>', ':lua require"dap".step_into()<CR>', opts)        -- 进入
    mapkey('n', '<F12>', ':lua require"dap".step_out()<CR>', opts)         -- 跳出

    mapkey('n', '<leader>du', ':lua require"dapui".toggle()<CR>', {noremap = true, silent = true, desc = "Debug: DAP UI"})
  end
}
