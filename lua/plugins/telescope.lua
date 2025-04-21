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
  local themes = require('telescope.themes')
  local config = require('telescope.config')

  return {
    defaults = {
      vimgrep_arguments = (function()
        local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

        -- search in hidden/dot files
        table.insert(vimgrep_arguments, '--hidden')
        table.insert(vimgrep_arguments, '--glob')
        table.insert(vimgrep_arguments, '!**/.git/*')
        table.insert(vimgrep_arguments, '--glob')
        table.insert(vimgrep_arguments, '!**/.node/*')

        return vimgrep_arguments
      end)(),
    },
    extensions = {
      ['ui-select'] = {
        themes.get_dropdown({}),
      },
    },
    pickers = {
      find_files = {
        -- Use ripgrep instead of find and show hidden/dotfiles as well
        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*', '--glob', '!**/.node/*' },
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
