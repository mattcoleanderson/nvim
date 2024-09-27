-- Live reload HTML, CSS, and JavaScript files inside neovim
-- Users NPM package, live-server
local M = {
  'barrett-ruth/live-server.nvim',
  enabled = vim.g.plugins.html_liveserver,
  build = 'npm install -g live-server',
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = true
}

return M
