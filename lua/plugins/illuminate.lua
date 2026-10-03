local M = {
  'RRethy/vim-illuminate',
  enabled = vim.g.plugins.illuminate,
  lazy = false,
}

M.opts = {
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  delay = 150,
  disable_keymaps = true,
}

M.config = function(_, opts)
  require('illuminate').configure(opts)

  local set_highlights = function()
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'LspReferenceText' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'LspReferenceRead' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'LspReferenceWrite' })
  end

  set_highlights()

  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('UserIlluminateHighlights', { clear = true }),
    callback = set_highlights,
  })
end

return M
