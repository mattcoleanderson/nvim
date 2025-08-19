-- https://www.josean.com/posts/neovim-linting-and-formatting

local M = {
  'mfussenegger/nvim-lint',
  enabled = vim.g.plugins.nvim_lint,
  event = { 'BufReadPre', 'BufNewFile' },
}

local get_lsp_client = function()
  local clients = vim.tbl_filter(function(c)
    return c.name ~= "null-ls"
  end, vim.lsp.get_clients({ bufnr = 0 }))

  return clients[1] or {}
end

M.config = function()
  local lint = require('lint')

  -- TODO: Find a way to custom configure these servers 
  -- TODO: Configure eslint_d to use the projects linter if available: https://github.com/mfussenegger/nvim-lint/issues/519
  lint.linters_by_ft = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    svelte = { 'eslint_d' },
    python = { 'pylint' },
  }

  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function ()
      local client = get_lsp_client()
      lint.try_lint(nil, { cwd = client.root_dir })
    end,
  })

  vim.keymap.set('n', '<leader>ll', function ()
    local client = get_lsp_client()
    lint.try_lint(nil, { cwd = client.root_dir })
  end, { desc = 'Trigger linting for current file' })

  -- Set pylint to work in a virtualenv
  -- https://gist.github.com/Norbiox/652befc91ca0f90014aec34eccee27b2
  lint.linters.pylint.cmd = 'python'
  lint.linters.pylint.args = { '-m', 'pylint', '-f', 'json' }

end

return M
