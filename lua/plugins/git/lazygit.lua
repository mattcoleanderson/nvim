local M = {
  'kdheepak/lazygit.nvim',
  enabled = vim.g.plugins.lazygit,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { '<leader>vg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
}

return M
