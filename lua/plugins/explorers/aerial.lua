local M = {
  'stevearc/aerial.nvim',
  enabled = vim.g.plugins.aerial,
  version = '*',
}

local set_keymaps = function(bufnr)
  local wk = require('which-key')
  wk.add({
    { '<leader>a',  group = 'aerial',           buffer = bufnr },
    { '<leader>aa', '<cmd>AerialToggle!<CR>',   desc = 'Toggle the aerial window',       buffer = bufnr },
    { '<leader>al', '<cmd>AerialPrev<CR>',      desc = 'Jump backwards [count] symbols', buffer = bufnr },
    { '<leader>ah', '<cmd>AerialNext<CR>',      desc = 'Jump forwards [count] symbols',  buffer = bufnr },
    { '<leader>an', '<cmd>AerialNavToggle<cr>', desc = 'Toggle the aerial nav window',   buffer = bufnr },
  })
end

M.opts = function()
  -- plugin options. These are internally passed as a table to the setup function
  return {
    on_attach = set_keymaps,
  }
end

return M
