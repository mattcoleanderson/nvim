local M = {
  'nvim-zh/colorful-winsep.nvim',
  enabled = vim.g.plugins.colorful_winsep,
  event = 'WinLeave',
}

M.opts = {
  border = 'single',
  animate = { enabled = false },
  -- Reapplied by the plugin when the colorscheme changes.
  highlight = function()
    -- Soft mint green, with a darker variant for light backgrounds.
    local green = vim.o.background == 'light' and '#507655' or '#80c997'
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
    vim.api.nvim_set_hl(0, 'ColorfulWinSep', { fg = green, bg = normal.bg })
  end,
}

M.config = function(_, opts)
  require('colorful-winsep').setup(opts)
end

return M
