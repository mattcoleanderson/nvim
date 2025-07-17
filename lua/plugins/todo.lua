local M = {
  'folke/todo-comments.nvim',
  enabled = vim.g.plugins.todo,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
}

M.config = function (_, opts)
  local plugin = require('todo-comments')

  -- Set up Keymaps
  local wk = require('which-key')
  wk.add({
    { '<leader>t', group = 'todo' },
    { '<leader>tn', function() plugin.jump_next() end, desc = 'Go to next TODO comment' },
    { '<leader>tp', function() plugin.jump_prev() end, desc = 'Go to previous TODO comment' },
    { '<leader>tf', '<cmd>TodoTelescope<CR>', desc = 'Search for TODO comments in Telescope' },
    { '<leader>tq', '<cmd>TodoQuickFix<CR>', desc = 'Open TODO comments in Quickfix list' },
  })

  plugin.setup(opts)
end

return M
