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
  -- debugpy is the Debug Adapter Protocol (DAP) server for python (Mine is installed through Mason to this directory)
  -- https://github.com/microsoft/debugpy
  local python = vim.fn.expand('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')

  require('dap-python').setup(python)
end

return M
