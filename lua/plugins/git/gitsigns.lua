local M = {
  'lewis6991/gitsigns.nvim',
  enabled = vim.g.plugins.gitsigns,
}

-- M.config = true
M.config = function(_, opts)
  local plugin = require('gitsigns')

  -- Set up Keymaps
  local wk = require('which-key')
  wk.add({
    { '<leader>v', group = 'vcs' },
    { '<leader>vn', '<cmd>Gitsigns next_hunk<CR>', desc = 'Go to Next Hunk' },
    { '<leader>vp', '<cmd>Gitsigns prev_hunk<CR>', desc = 'Go to Previous Hunk' },
  })

  plugin.setup(opts)
end

return M
