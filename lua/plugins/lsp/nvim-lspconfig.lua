-- TODO: Consider doing away with lspconfig in favor of builtin
-- lsp setup introduced by Neovim 0.11
-- Helpful blog post: https://gpanders.com/blog/whats-new-in-neovim-0-11/#lsp
local M = {
  'neovim/nvim-lspconfig',
  enabled = vim.g.plugins.nvim_lspconfig,
}

-- TODO: move these to an importable module for use in mason as well

-- Name of server: name of module file
local servers = {
  ts_ls = 'typescript',
  lua_ls = 'lua',
  texlab = 'latex',
  html = 'html',
  basedpyright = 'python',
  bashls = 'bash',
  dockerls = 'docker',
  jsonls = 'json',
  yamlls = 'yaml',
  clangd = 'c',
}

-- TODO: user runtimepath scanning feature to simply setup lspconfigs
-- https://gpanders.com/blog/whats-new-in-neovim-0-11/#lsp
--    Link to exact comment: https://arc.net/l/quote/aozwckjh
local setup_servers = function()
  for name, module in pairs(servers) do
    vim.lsp.config[name] = require('plugins.lsp.lang.' .. module)
    vim.lsp.enable(name)
  end
end

local add_diagnostic_keybindings = function()
  local wk = require('which-key')

  wk.add({ '<leader>x', group = 'diagnositcs' })
  vim.keymap.set('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Open diagnostic modal' })
  vim.keymap.set(
    'n',
    '<leader>xh',
    function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = 'Go to previous diagnostic' }
  )
  vim.keymap.set(
    'n',
    '<leader>xl',
    function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = 'Go to next diagnostic' }
  )
end

local add_lsp_specific_keybindings = function()
  local wk = require('which-key')

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
          vim.lsp.buf.declaration,
          buffer = ev.buf,
          desc = 'Jumps to the declaration of the symbol under the cursor.',
        },
        {
          '<leader>lk',
          function() vim.lsp.buf.hover({ border = 'rounded', title = ' hover ' }) end,
          buffer = ev.buf,
          desc = 'Displays info about the symbol under the cursor.',
        },
        {
          'K',
          function()
            vim.lsp.buf.hover({ border = 'rounded', title = ' hover ' })
          end,
          buffer = ev.buf,
          desc = 'Displays info about the symbol under the cursor.',
          cond = function ()
            return vim.bo.filetype ~= 'c' -- I have cutom function set in /ftplugin/c.lua
          end
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
          mode = 'nv',
        },
      })
    end,
  })
end

M.config = function()
  setup_servers()
  add_diagnostic_keybindings()
  add_lsp_specific_keybindings()
end

return M
