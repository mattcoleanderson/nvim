local M = {
  'folke/lazydev.nvim',
  ft = 'lua', -- only load on lua files
  dependencies = {
    { 'justinsgithub/wezterm-types', lazy = true },
    { 'hrsh7th/nvim-cmp' },
  },
  opts = {
    library = {
      -- See the configuration section for more details
      { path = 'wezterm-types',      mods = { 'wezterm' } },
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
  config = function(_, opts)
    require('lazydev').setup(opts)

    -- extend cmp once lazydev is loaded
    local cmp = require('cmp')
    cmp.setup({
      sources = cmp.config.sources({
        { name = 'lazydev', group_index = 0 },
      }, cmp.get_config().sources),
    })
  end,
}

return M
