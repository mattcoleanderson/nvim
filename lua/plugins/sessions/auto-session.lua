local M = {
  'rmagatti/auto-session',
  enabled = vim.g.plugins.auto_session,
  lazy = false,
  keys = function()
    local wk = require('which-key')
    wk.add({ '<leader>S', group = 'sessions' })
    return {
      { "<leader>Sf", "<cmd>SessionSearch<CR>",         desc = "Session search" },
      { "<leader>Ss", "<cmd>SessionSave<CR>",           desc = "Save session" },
      { "<leader>Sa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
    }
  end,

  ---@module 'auto-session'
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- Install missing tree-sitter parsers before restoring a session so that
    -- filetype detection doesn't error on unknown languages.
    pre_restore_cmds = {
      function()
        local ok, ts_install = pcall(require, 'nvim-treesitter.install')
        if ok then
          ts_install.ensure_installed_sync = ts_install.ensure_installed_sync or function() end
        end
      end,
    },
  }
}

return M
