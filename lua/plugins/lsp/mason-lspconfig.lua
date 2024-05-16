return {
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'lua_ls@3.7.4',
        'tsserver',
      }
    },
  }
}
