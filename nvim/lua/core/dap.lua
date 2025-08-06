-- lua/core/dap.lua

local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  -- Set up the Go debugger (Delve)
  dap.adapters.go = {
    type = 'executable',
    command = 'dlv',
    args = { 'dap' },
  }

  dap.configurations.go = {
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      program = '${file}',
    },
    {
      type = 'go',
      name = 'Debug Package',
      request = 'launch',
      program = '${fileDirname}',
    },
  }

  -- Set up the Lua debugger (optional for Neovim plugin dev)
  dap.configurations.lua = {
    {
      type = 'nlua',
      request = 'attach',
      name = "Attach to running Neovim instance",
      host = function()
        return "127.0.0.1"
      end,
      port = function()
        return tonumber(vim.fn.input('Port: '))
      end
    }
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host, port = config.port })
  end

  -- Set up dap-ui and virtual text
  dapui.setup()
  require("nvim-dap-virtual-text").setup()

  -- Automatically open/close UI
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M

