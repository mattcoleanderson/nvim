-- LuaSnip is a snippet engine
-- A good example of a config with this setup is: https://github.com/lcfd/NaryaVim/blob/main/lua/plugins/snippets.lua
local M = {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets', -- repository of snippets for different languages
  },
  lazy = true,
  opts = function()
    require('luasnip.loaders.from_vscode').lazy_load()

    return {}
  end,
}

return M
