-- Mason is a package manager for LSPs, Linters, Parsers, and Formatters
return {
  {
    'williamboman/mason.nvim', -- Mason Package manager
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim', -- Helper function to explicitly state LSPs to install.
    opts = {
      ensure_installed = {
        'lua_ls@3.7.4', -- Lua
        'tsserver',     -- TypeScript
        'texlab',       -- LaTeX
      },
    },
  },
}
