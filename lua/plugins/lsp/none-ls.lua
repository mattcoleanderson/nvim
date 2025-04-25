-- none-ls is the predecessor to null-ls
-- An API to expose Formatters, Linters, and Parsers to the LSP API
-- These tools are typically command line.
-- with none-ls they can be used with editor commands and events
local M = {
  'nvimtools/none-ls.nvim',
  dependency = { 'nvim-lua/plenary.nvim' },
  enabled = vim.g.plugins.none_ls,
  main = 'null-ls',
}

M.opts = function()
  local none_ls = require('null-ls')

  return {
    sources = {
      none_ls.builtins.formatting.stylua,
      none_ls.builtins.formatting.black,
      none_ls.builtins.formatting.shfmt,
      none_ls.builtins.formatting.prettier,
    },
  }
end

return M
