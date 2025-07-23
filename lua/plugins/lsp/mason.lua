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
      automatic_enable = false, -- prevents duplicate lsp attachment if setup is called elsewhere
      ensure_installed = {
        'lua_ls', -- Lua
        'ts_ls',        -- TypeScript
        'texlab',       -- LaTeX
        'html',         -- HTML
        -- 'pyright',      -- Python
        'basedpyright', -- Python
        -- 'jdtls',        -- Java
        'bashls',       -- Bash
        'dockerls',     -- Dockerfile
        'jsonls',       -- JSON
        'yamlls',       -- YAML
      },
    },
  },
}
