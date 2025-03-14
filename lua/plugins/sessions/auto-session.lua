local M = {
  'rmagatti/auto-session',
  enabled = vim.g.plugins.auto_session,
  lazy = false,

  ---@module 'auto-session'
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  }
}

return M
