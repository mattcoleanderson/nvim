local obsidian_dir = vim.fn.expand('~') .. '/repos/personal/obsidian-personal-vault'

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- '*' installs the latest stable version from github
  lazy = true,
  event = {
    'BufReadPre ' .. obsidian_dir .. '/**.md',
    'BufNewFile ' .. obsidian_dir .. '/**.md',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>of', '<cmd>ObsidianFollowLink<cr>', desc = 'Obsidian: Follow link under cursor' },
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = obsidian_dir,
      },
    },
    disable_frontmatter = true,
  },
}
