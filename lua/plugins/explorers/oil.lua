local M = {
  'stevearc/oil.nvim',
  enabled = vim.g.plugins.oil,
  version = '*',
  --@module 'oil'
  --@type oil.SetupOpts
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
}

return M
