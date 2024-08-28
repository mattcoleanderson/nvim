return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local wk = require('which-key')

      lspconfig.tsserver.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.texlab.setup({})

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
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
          })
        end,
      })
    end,
  },
}
