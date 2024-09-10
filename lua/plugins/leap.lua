local M = {
  'ggandor/leap.nvim',
  enabled = vim.g.plugins.leap,
}

M.lazy = false

M.config = function()
  -- Set up Keymap
  local wk = require('which-key')
  wk.add({
    { 's', '<Plug>(leap)' },
    { 'S', '<Plug>(leap-from-window)' },
    { 's', '<Plug>(leap-forward)',    mode = { 'x', 'o' } },
    { 'S', '<Plug>(leap-forward)',    mode = { 'x', 'o' } },
  })
end

return M
