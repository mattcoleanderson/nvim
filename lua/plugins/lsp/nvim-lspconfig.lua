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

local setup_servers = function()
  local lspconfig = require('lspconfig')

  for name, module in pairs(servers) do
    local config = require('plugins.lsp.lang.' .. module)
    lspconfig[name].setup(config)
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
            local ft = vim.bo.filetype
            if ft == 'c' then
              local cword = vim.fn.expand('<cword>')

              local _ = vim.fn.system({ 'man', '-w', '-a', cword })
              if vim.v.shell_error ~= 0 then
                vim.notify('No manual entry for ' .. cword, vim.log.levels.ERROR)
                return
              end

              local bufnr = vim.api.nvim_create_buf(false, true)

              --- open floating win
              local width = math.floor(vim.o.columns * 0.6)
              local height = math.floor(vim.o.lines * 0.6)
              local row = math.floor((vim.o.lines - height) / 2)
              local col = math.floor((vim.o.columns - width) / 2)

              vim.api.nvim_open_win(bufnr, true, {
                relative = 'editor',
                row = row,
                col = col,
                width = width,
                height = height,
                style = 'minimal',
                border = 'rounded',
                title = ' man ' .. cword .. ' ',
              })
              vim.cmd('hide Man ' .. cword)
              vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })
            else
              vim.lsp.buf.hover({ border = 'rounded', title = ' hover ' })
            end
          end,
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
