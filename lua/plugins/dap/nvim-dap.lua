-- NVIM DAP creates an API for interfacing with DAP servers
-- It does not configure DAP servers for filetypes
-- https://www.johntobin.ie/blog/debugging_in_neovim_with_nvim-dap/
local M = {
  'mfussenegger/nvim-dap',
  lazy = true,
  keys = function()
    local wk = require('which-key')
    wk.add({ '<leader>d', group = 'debug' })

    return {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dB', function() require('dap').clear_breakpoints() end, desc = 'Clear all Breakpoints' },
      { '<leader>dL', function() require('dap').list_breakpoints() end, desc = 'List all Breakpoints' },
      { '<leader>dc', function() require('dap').continue() end,          desc = 'Continue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end,     desc = 'Run to Cursor' },
      { '<leader>dp', function() require('dap').run_last() end,     desc = 'Re-Run the last debug adapter' },
      { '<leader>dt', function() require('dap').terminate() end,         desc = 'Terminate' },
      { '<leader>de', function() require('dap').repl.toggle() end,       desc = 'Toggle REPL' },

      -- TODO: set these to these temporarliy to the arrow keys using debug session
      -- event listeners. See `:help dap-listeners`
      { '<leader>dj', function() require('dap').step_over() end,         desc = 'Step over' },
      { '<leader>dl', function() require('dap').step_into() end,         desc = 'Step into' },
      { '<leader>dh', function() require('dap').step_out() end,          desc = 'Step out' },
      { '<leader>dk', function() require('dap').restart_frame() end,     desc = 'Restart frame' },
      -- Step back isn't usually implemented by debug adapters
      -- { '<leader>dt', function() require('dap').step_back() end,         desc = 'Step back' },
    }
  end,
}

return M
