local M = {
  'hrsh7th/nvim-cmp',
  enabled = vim.g.plugins.nvim_cmp,
}

M.dependencies = {
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip',
  -- Zsh completion
  {
    'tamago324/cmp-zsh',
    opts = {
      zshrc = true,
      filetypes = { 'zsh' },
    },
  },
  -- 'Shougo/deol.nvim',
}

M.config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
      ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<C-n>'] = cmp.mapping(function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-p>'] = cmp.mapping(function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'zsh' }, -- for cmp-zsh
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
  })

  -- Use buffer source for '/' and '?'
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- Add additional capabilities from nvim-cmp to lsp
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Enable some language servers with additional completion capabilities
  local servers = { 'lua_ls', 'texlab', 'html' }
  for _, lsp in ipairs(servers) do
    vim.lsp.config(lsp, {
      capabilities = capabilities
    })
  end
end

return M
