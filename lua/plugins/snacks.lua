-- lazy.nvim
local M = {
  'folke/snacks.nvim',
}

---@type snacks.Config
M.opts = {
  terminal = {
    win = {
      position = 'float',
      width = 0.9,
      height = 0.9,
    },
  },
}

M.keys = function()
  require('which-key').add({
    { '<leader>c', group = 'cli' },
  })

  return {
    { '<leader>cc', function() Snacks.terminal.toggle() end, desc = 'Toggle terminal' },
  }
end

return M
