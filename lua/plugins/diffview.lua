local M = {
  'sindrets/diffview.nvim',
  enabled = vim.g.plugins.diffview,
}

M.config = function(_, opts)
  local plugin = require('diffview')
  local wk = require('which-key')

  wk.add({
    { '<leader>vd', group = 'diffview' },
    { '<leader>vdo', '<cmd>DiffviewOpen<CR>', desc = 'Open diff view' },
    { '<leader>vdc', '<cmd>DiffviewClose<CR>', desc = 'Close diff view' },
    { '<leader>vdh', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history (current file)' },
    { '<leader>vdH', '<cmd>DiffviewFileHistory<CR>', desc = 'File history (all files)' },
    { '<leader>vdf', '<cmd>DiffviewToggleFiles<CR>', desc = 'Toggle file panel' },
    { '<leader>vdr', '<cmd>DiffviewRefresh<CR>', desc = 'Refresh diff view' },
    { '<leader>vdm', '<cmd>DiffviewOpen HEAD...MERGE_HEAD<CR>', desc = 'Open merge conflicts' },
  })

  plugin.setup(opts)
end

return M
