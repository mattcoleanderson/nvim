local M = {
  'nvim-telescope/telescope.nvim',
  enabled = vim.g.plugins.telescope,
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
}

M.keys = {
  { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Search all project files' },
  { '<leader>fg', '<cmd>Telescope git_files<cr>',  desc = 'Telescope: Search git files' },
  {
    '<leader>fs',
    '<cmd>Telescope live_grep<cr>',
    desc = 'Telescope: Search for a string the current working directory',
  },
}

M.opts = function()
  local theme = require('telescope.themes').get_dropdown({})
  return {
    extensions = {
      ['ui-select'] = {
        theme,
      },
    },
  }
end

M.config = function(_, opts)
  local plugin = require('telescope')

  plugin.setup(opts)
  plugin.load_extension('ui-select')
end

return M
