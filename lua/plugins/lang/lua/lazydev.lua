local M = {
  'folke/lazydev.nvim',
  ft = 'lua', -- only load on lua files
  dependencies = {
    { 'justinsgithub/wezterm-types', lazy = true },
    {
      'hrsh7th/nvim-cmp',
      ---@type fun(_, opts: cmp.ConfigSchema)
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0,
        })
      end,
    },
  },
  opts = {
    library = {
      -- See the configuration section for more details
      { path = 'wezterm-types', mods = { 'wezterm' } },
    },
  },
}

return M
