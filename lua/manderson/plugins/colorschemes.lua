return {
  -- catppuccin
  { 
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      -- Set colorscheme
      vim.cmd.colorscheme('catppuccin')
      -- Add some transparency
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end
  }
}
