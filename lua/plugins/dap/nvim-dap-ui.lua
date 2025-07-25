local M = {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  keys = {
    {
      '<leader>du',
      function ()
        require('dapui').toggle({})
      end,
      desc = 'Toggle the DAP UI',
    },
  },
}

M.opts = {}

return M
