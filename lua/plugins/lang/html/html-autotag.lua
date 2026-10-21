local M = {
  'windwp/nvim-ts-autotag',
  enabled = vim.g.plugins.html_autotag,
  lazy = false,
  opts = {},
}

M.config = function(_, opts)
  require('nvim-ts-autotag').setup(opts)

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('JsxTagNewline', { clear = true }),
    pattern = { 'javascriptreact', 'typescriptreact' },
    callback = function(event)
      vim.keymap.set('i', '<CR>', function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]

        -- Split adjacent JSX tags and leave the cursor on an indented line.
        if line:sub(col, col) == '>' and line:sub(col + 1):match('^</') then
          return '<CR><Esc>O<C-t>'
        end

        return '<CR>'
      end, { buffer = event.buf, expr = true, desc = 'New line between JSX tags' })
    end,
  })
end

return M
