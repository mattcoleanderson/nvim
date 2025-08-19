-- Python Debug Adapter Protocol (DAP) configuration plugin
-- For this to work, you must install debugpy through Mason
local M = {
  'mfussenegger/nvim-dap-python',
  ft = 'python', -- lazy load when py file is opened
  dependencies = {
    'mfussenegger/nvim-dap',
  },
}

M.config = function()
  local dap_python = require('dap-python')
  local dap = require('dap')

  -- debugpy is the Debug Adapter Protocol (DAP) server for python (Mine is installed through Mason to this directory)
  -- https://github.com/microsoft/debugpy
  local python = vim.fn.expand('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')

  dap_python.setup(python)

  -- Add remote Docker attach configuration
  table.insert(dap.configurations.python, {
    name = 'Attach to Docker',
    type = 'python',
    request = 'attach',
    connect = { host = '127.0.0.1', port = 5678 },
    mode = 'remote',
    justMyCode = false,
    pathMappings = {
      {
        localRoot = '/Users/matt.anderson/repos/work/TANF-app/tdrs-backend', -- local project root
        remoteRoot = '/tdpapp', -- container WORKDIR
      },
    },
  })
end

return M
