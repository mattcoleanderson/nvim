local plugins = {
  --explorers
  neotree = true,
  aerial = true,
  -- git
  gitsigns = true,
  lazygit = true,
  -- lang
  html_autotag = true,
  html_liveserver = true,
  obsidian = true,
  vimtex = true,
  nvim_java = false,
  -- lsp
  mason = true,
  mason_lspconfig = true,
  none_ls = true,
  nvim_lspconfig = true,
  nvim_lint = true,
  -- snippets
  luasnip = true,
  nvim_cmp = true,
  -- colorschemes
  catppuccin = true,
  -- core
  better_escape = true,
  bufferline = true,
  leap = true,
  lualine = true,
  telescope = true,
  treesitter = true,
  whichkey = true,
  diffview = true,
}

-- create global table 'plugins'
-- this variable will be added to the 'enabled' field of every plugin
-- to allow the plugin to be toggled on or off from here.
vim.g.plugins = plugins
