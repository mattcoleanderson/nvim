local M = {
  'OXY2DEV/markview.nvim',
  enabled = vim.g.plugins.markview,
  lazy = false,
  priority = 49,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

M.opts = {
  preview = {
    icon_provider = 'devicons', -- "mini" or "devicons"
  },
}

return M
