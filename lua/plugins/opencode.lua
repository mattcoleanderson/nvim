local M = {
  'nickjvandyke/opencode.nvim',
  enabled = vim.g.plugins.opencode,
  branch = 'main', -- OpenCode V2 support
  opts = {},
}

M.config = function(_, opts)
  ---@type opencode.Opts
  vim.g.opencode_opts = opts

  local plugin = require('opencode')
  local wk = require('which-key')

  wk.add({
    { '<leader>o', group = 'opencode', mode = { 'n', 'x' } },
    { '<leader>oa', function() plugin.ask('@this: ') end, mode = { 'n', 'x' }, desc = 'Ask OpenCode' },
    { '<leader>os', function() plugin.select() end, mode = { 'n', 'x' }, desc = 'Select OpenCode action' },
    {
      '<leader>oo',
      function() return plugin.operator('@this') end,
      mode = { 'n', 'x' },
      expr = true,
      desc = 'Send range to OpenCode',
    },
    {
      '<leader>ol',
      function() return plugin.operator('@this') .. '_' end,
      expr = true,
      desc = 'Send line to OpenCode',
    },
  })
end

return M
