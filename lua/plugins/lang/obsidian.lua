local M = {
  'epwalsh/obsidian.nvim',
  enabled = vim.g.plugins.obsidian,
  version = '*', -- '*' installs the latest stable version from github
  lazy = true,
}

local obsidian_dir = vim.fn.expand('~') .. '/repos/personal/obsidian-personal-vault'

M.event = {
  'BufReadPre ' .. obsidian_dir .. '/**.md',
  'BufNewFile ' .. obsidian_dir .. '/**.md',
}

M.dependencies = {
  'nvim-lua/plenary.nvim',
}

M.opts = function()
  -- Local Keymaps
  -- only created when plugin is loaded
  vim.keymap.set('n', '<localleader>f', '<cmd>ObsidianFollowLink<cr>', { desc = 'Obsidian: Follow link under cursor' })

  -- plugin options
  return {
    workspaces = {
      {
        name = 'personal',
        path = obsidian_dir,
      },
    },
    disable_frontmatter = true,
  }
end

return M
