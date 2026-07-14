return {
  {
    'akinsho/bufferline.nvim',
    enabled = vim.g.plugins.bufferline,
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    ---@module 'bufferline'
    ---@type bufferline.UserConfig
    opts = {
      options = {
        numbers = 'ordinal',
        offsets = {
          {
            filetype = 'neo-tree',
            text_align = 'left',
            separator = true,
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Re-setup bufferline when colorscheme changes (e.g. dark/light mode switch)
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function() require('bufferline').setup(opts) end,
      })
    end,
  },
}
