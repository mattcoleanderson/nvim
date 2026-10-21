local M = {
  'nvim-treesitter/nvim-treesitter',
  enabled = vim.g.plugins.treesitter,
  lazy = false,
  build = ':TSUpdate',
  dependencies = { 'OXY2DEV/markview.nvim' },
}

M.config = function()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
    callback = function(event)
      -- Skip filetypes without an installed parser.
      pcall(vim.treesitter.start, event.buf)
    end,
  })
end

return M
