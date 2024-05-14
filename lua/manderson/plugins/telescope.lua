return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {'nvim-lua/plenary.nvim'},
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Search all project files' },
      { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Telescope: Search git files' }
    }
  }
}
