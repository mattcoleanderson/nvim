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
  }
}

return M
