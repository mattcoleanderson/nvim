return {
  -- catppuccin
  {
    'catppuccin/nvim',
    enabled = vim.g.plugins.catppuccin,
    lazy = false,
    name = 'catppuccin',
    priority = 1000,

    init = function()
      vim.g.colorscheme = 'catppuccin'
    end,
    config = function()
      -- Set colorscheme
      vim.cmd.colorscheme('catppuccin')
      -- Add some transparency
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    enabled = vim.g.plugins.cyberdream,
    lazy = false,
    priority = 1000,

    init = function()
      vim.g.colorscheme = 'cyberdream'
    end,

    ---@type Config
    opts = {
      variant = 'default',
      transparent = true,
      borderless_pickers = false,
      terminal_colors = true,
      hide_fillchars = false,
      extensions = {
        treesitter = true,
        telescope = true,
      },
    },
  },
}
