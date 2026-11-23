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

  -- V2 file-change events aren't always emitted for agent edits. Before 0.13's
  -- native filesystem watching, check saved buffers while OpenCode is connected.
  -- Stop the previous timer if this configuration is loaded again.
  if vim.g.opencode_reload_timer then
    vim.fn.timer_stop(vim.g.opencode_reload_timer)
    vim.g.opencode_reload_timer = nil
  end
  if vim.fn.has('nvim-0.13') == 0 then
    vim.g.opencode_reload_timer = vim.fn.timer_start(1000, function()
      local server = package.loaded['opencode.server']
      local config = require('opencode.config').opts
      local mode = vim.api.nvim_get_mode()
      if not (server and server.connected and config.events.reload.enabled) or mode.mode ~= 'n' or mode.blocking then
        return
      end

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          local autoread = vim.bo[buf].autoread
          if autoread == nil then autoread = vim.go.autoread end
          if
            autoread
            and vim.bo[buf].buftype == ''
            and not vim.bo[buf].modified
            and vim.fn.filereadable(vim.api.nvim_buf_get_name(buf)) == 1
          then
            vim.cmd('silent checktime ' .. buf)
          end
        end
      end
    end, { ['repeat'] = -1 })
  end

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
