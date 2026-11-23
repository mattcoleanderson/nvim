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

  local function switch_agent(agent)
    -- Reuse the plugin's authentication and prompt session targeting.
    require('opencode.server.discovery')
      .get()
      :next(function(server)
        return server:resolve_session():next(function(session)
          return server:request('/api/session/' .. session.id .. '/agent', 'POST', { agent = agent })
        end)
      end)
      :next(function()
        vim.notify('Switched OpenCode to ' .. agent, vim.log.levels.INFO, { title = 'opencode' })
      end)
      :catch(function(err)
        if err then
          vim.notify('Failed to switch OpenCode agent: ' .. tostring(err), vim.log.levels.ERROR, { title = 'opencode' })
        end
      end)
  end

  wk.add({
    { '<leader>o', group = 'opencode', mode = { 'n', 'x' } },
    { '<leader>oa', function() plugin.ask('@this: ') end, mode = { 'n', 'x' }, desc = 'Ask OpenCode' },
    { '<leader>os', function() plugin.select() end, mode = { 'n', 'x' }, desc = 'Select OpenCode action' },
    { '<leader>op', function() switch_agent('plan') end, desc = 'Switch OpenCode to Plan' },
    { '<leader>ob', function() switch_agent('build') end, desc = 'Switch OpenCode to Build' },
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
