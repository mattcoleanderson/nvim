--[[
There are many ways to set vim options including:
  vim.cmd('set wrap')
  vim.opt.wrap = false
  vim.o.wrap = false
]]

-- Set all vim options in this table
local options = {
  number = true, -- Show absolute line numbers
  relativenumber = true, -- Show relative line numbers
  expandtab = true,
  tabstop = 4,
  softtabstop = 2,
  shiftwidth = 2,
  wrap = false,
  conceallevel = 2,
  signcolumn = 'auto:3', -- Allows the signcolumn (gutter) to display up to X signs per line
  laststatus = 3,
  winborder = 'rounded', -- adds border to floating windows

  -- Folding: default to treesitter, upgraded to LSP per-buffer via LspAttach
  foldmethod = 'expr',
  foldexpr = 'v:lua.vim.treesitter.foldexpr()',
  foldtext = '',
  foldlevel = 99,
  foldlevelstart = 99,
}

-- The above table will be iterated to set options individually
for option, value in pairs(options) do
  vim.opt[option] = value
end

-- Sync vim.o.background with macOS dark/light mode
local function sync_macos_appearance()
  local result = vim.fn.system('defaults read -g AppleInterfaceStyle 2>/dev/null')
  vim.o.background = result:find('Dark') and 'dark' or 'light'
end

sync_macos_appearance()
vim.api.nvim_create_autocmd('FocusGained', { callback = sync_macos_appearance })

-- When an LSP client that supports folding attaches, use LSP folds instead of treesitter
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspFolding', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
