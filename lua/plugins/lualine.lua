local cyberdream = require('lualine.themes.cyberdream')

return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = vim.g.plugins.lualine,
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    ---@module 'lualine'
    opts = {
      options = {
        -- theme = require('lualine.themes.dracula'),
        theme = 'cyberdream',
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 10,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'lsp_status', ignore_lsp = { 'null-ls' } } },
        -- lualine_c = {
        --   function() return require('auto-session.lib').current_session_name(true) end,
        -- },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      winbar = {
        lualine_a = { { 'filetype', icon_only = true } },
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = { 'diff' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'aerial' },
      },
      inactive_winbar = {
        lualine_a = { 'filename' },
        lualine_b = { 'diff' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
}
