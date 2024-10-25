-- Mason is a package manager for LSPs, Linters, Parsers, and Formatters
return {
  {
    'williamboman/mason.nvim', -- Mason Package manager
    enabled = vim.g.plugins.mason,
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim', -- Helper function to explicitly state LSPs to install.
    enabled = vim.g.plugins.mason_lspconfig,
    opts = {
      ensure_installed = {
        'lua_ls@3.7.4', -- Lua
        'ts_ls',     -- TypeScript
        'texlab',       -- LaTeX
        'html',         -- HTML
        'pylsp',        -- Python
        -- 'jdtls',        -- Java
      },
    },
  },
}
