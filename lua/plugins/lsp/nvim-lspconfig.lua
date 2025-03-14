return {
  {
    'neovim/nvim-lspconfig',
    enabled = vim.g.plugins.nvim_lspconfig,
    config = function()
      local lspconfig = require('lspconfig')
      local wk = require('which-key')

      lspconfig.ts_ls.setup({})

      lspconfig.lua_ls.setup({
        on_attach = function(client, _)
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
          client.server_capabilities.documentFormattingProvider = false -- turn off lsp formatting, want to use none_ls instead
        end,
      })

      lspconfig.texlab.setup({})
      lspconfig.html.setup({})
      -- lspconfig.pylsp.setup(require('plugins.lsp.lang.python').config)
      lspconfig.pyright.setup({})
      -- lspconfig.jdtls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.dockerls.setup({})

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      -- Global mappings
      -- Diagnostics
      wk.add({ '<leader>d', group = 'diagnositcs' })
      vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open diagnostic modal' })
      vim.keymap.set('n', '<leader>dl', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
      vim.keymap.set('n', '<leader>dh', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

      -- LspAttach autocommand will only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' ---@diagnostic disable-line: no-unknown

          -- Buffer local mappings
          -- local opts = { buffer = ev.buf }
          wk.add({
            { '<leader>l', group = 'lsp' },
            {
              '<leader>ld',
              vim.lsp.buf.definition,
              buffer = ev.buf,
              desc = 'Jumps to the definition of the symbol under the cursor.',
            },
            {
              '<leader>lD',
              vim.lsp.buf.declation,
              buffer = ev.buf,
              desc = 'Jumps to the declaration of the symbol under the cursor.',
            },
            {
              '<leader>lk',
              vim.lsp.buf.hover,
              buffer = ev.buf,
              desc = 'Displays info about the symbol under the cursor.',
            },
            {
              '<leader>ls',
              vim.lsp.buf.signature_help,
              buffer = ev.buf,
              desc = 'Displays signature info about the symbol under the cursor.',
            },
            {
              '<leader>li',
              vim.lsp.buf.implementation,
              buffer = ev.buf,
              desc = 'Lists all implementations of the symbol under the cursor.',
            },
            {
              '<leader>lc',
              vim.lsp.buf.code_action,
              buffer = ev.buf,
              desc = 'Selects a code action available at the current cursor position.',
            },
            {
              '<leader>lf',
              vim.lsp.buf.format,
              buffer = ev.buf,
              desc = 'Formats a buffer using the attached language server clients.',
            },
          })
        end,
      })
    end,
  },
}
