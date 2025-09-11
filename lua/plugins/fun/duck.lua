---@module 'lazy'
---@type LazySpec
return {
  'tamton-aquib/duck.nvim',
  keys = {
    { '<leader>gfh', function() require('duck').hatch() end, desc = 'Hatch a duck' },
    { '<leader>gfc', function() require('duck').cook() end, desc = 'Cook a duck' },
    { '<leader>gfa', function() require('duck').cook_all() end, desc = 'Cook all ducks' },
  }
}
