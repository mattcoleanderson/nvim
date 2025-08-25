local M = {
  'rmagatti/auto-session',
  enabled = vim.g.plugins.auto_session,
  lazy = false,
  keys = function()
    local wk = require('which-key')
    wk.add({ '<leader>S', group = 'sessions' })
    return {
      { "<leader>Sf", "<cmd>SessionSearch<CR>",         desc = "Session search" },
      { "<leader>Ss", "<cmd>SessionSave<CR>",           desc = "Save session" },
      { "<leader>Sa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
    }
  end,

  ---@module 'auto-session'
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  }
}

return M
