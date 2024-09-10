return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = vim.g.plugins.lualine,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'dracula',
      },
    },
  },
}
