local M = { 'iamcco/markdown-preview.nvim' }

M.cmd = {
  'MarkdownPreviewToggle',
  'MarkdownPreview',
  'MarkdownPreviewStop',
}

M.ft = { 'markdown' }

M.build = function(plugin)
  if vim.fn.executable('npx') then
    vim.cmd('!cd ' .. plugin.dir .. ' && cd app && npx --yes yarn install')
  else
    vim.cmd([[Lazy load markdown-preview.nvim]])
    vim.fn['mkdp#util#install']()
  end
end

M.init = function()
  if vim.fn.executable('npx') then
    vim.g.mkdp_filetypes = { 'markdown' }
  end
end

return M
