-- none-ls is the predecessor to null-ls
-- An API to expose Formatters, Linters, and Parsers to the LSP API
-- These tools are typically command line.
-- with none-ls they can be used with editor commands and events
return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls') -- none-ls is still internally called null-ls

    null_ls.setup({
      -- Add Formatters, Linters, and Parsers you'd wish to be exposed to LSP API
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })

    -- Keymaps
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end,
}
