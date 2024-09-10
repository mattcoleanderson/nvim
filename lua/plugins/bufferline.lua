return {
  {
    'akinsho/bufferline.nvim',
    enabled = vim.g.plugins.bufferline,
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        numbers = 'ordinal',
      },
    },
  },
}
