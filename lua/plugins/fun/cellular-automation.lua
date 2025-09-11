---@module 'lazy'
---@type LazySpec
return {
  'eandrju/cellular-automaton.nvim',
  keys = function ()
    require('which-key').add({ '<leader>gf', group = 'fun' })

    return {
      { '<leader>gfr', '<cmd>CellularAutomaton make_it_rain<CR>', desc = 'Make characters rain! (press \'q\' to stop)' },
    }
  end
}

