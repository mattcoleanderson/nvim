return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = vim.g.plugins.lualine,
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    ---@module 'lualine'
    opts = {
      options = {
        theme = 'auto',
      },
      sections = {
        lualine_c = {
          function() return require('auto-session.lib').current_session_name(true) end,
        },
      },
    },
  },
}
