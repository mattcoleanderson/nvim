local M = {}

-- Returns the path to the current python interpreter
-- found here: https://github.com/williamboman/mason.nvim/issues/1276#issuecomment-1926818488
local function which_python()
  local f = io.popen('env which python', 'r') or error('Fail to execute "env which python"')
  local s = f:read('*a') or error('Fail to read from io.popen result')
  f:close()
  return string.gsub(s, '%s+$', '')
end

M.config = {
  settings = {
    pylsp = {
      plugins = {
        jedi = {
          environment = which_python(), -- sets the environment for autocomplete
        }
      }
    }
  },
  on_attach = function(client, _)
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
    client.server_capabilities.documentFormattingProvider = false       -- turn off lsp formatting, want to use none_ls instead
  end,
}

return M
