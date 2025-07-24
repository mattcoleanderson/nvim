local M = {
  'goolord/alpha-nvim',
}

M.config = function()
  local alpha = require('alpha')
  local dashboard = require('alpha.themes.dashboard')

  alpha.setup(dashboard.config)
end

return M
