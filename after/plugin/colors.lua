function PaintMyBuffers(color)
  -- Set the color scheme
  color = color or 'catppuccin'
  vim.cmd.colorscheme(color)

  -- Add some transparency
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

PaintMyBuffers()
