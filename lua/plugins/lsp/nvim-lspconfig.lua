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
}

local setup_servers = function()
  local lspconfig = require('lspconfig')

  for name, module in pairs(servers) do
    local config = require('plugins.lsp.lang.' .. module)
    lspconfig[name].setup(config)
  end
end

local add_diagnostic_keybindings = function ()
  local wk = require('which-key')

  wk.add({ '<leader>d', group = 'diagnositcs' })
  vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open diagnostic modal' })
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
  vim.keymap.set('n', '<leader>dh', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
end

local add_lsp_specific_keybindings = function ()
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
