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
    pattern = { 'html', 'javascriptreact', 'typescriptreact' },
    callback = function(event)
      vim.keymap.set('i', '<CR>', function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]

        -- Split adjacent JSX tags and leave the cursor on an indented line.
        if line:sub(col, col) == '>' and line:sub(col + 1):match('^</') then
          return '<CR><Esc>O<C-t>'
        end

        local ok, node = pcall(vim.treesitter.get_node, {
          pos = { vim.api.nvim_win_get_cursor(0)[1] - 1, math.max(col - 1, 0) },
        })
        while ok and node do
          local kind = node:type()
          -- Leave Enter alone inside attribute values and JSX expressions.
          if kind == 'string' or kind == 'quoted_attribute_value' or kind == 'jsx_expression' then
            local _, _, end_row, end_col = node:range()
            local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
            if cursor_row < end_row or (cursor_row == end_row and col < end_col) then
              break
            end
          end

          if kind == 'jsx_opening_element' or kind == 'jsx_self_closing_element' or kind == 'start_tag' then
            local row = node:start()
            local opening_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
            local indent = opening_line:match('^%s*')
            local attribute_indent = indent .. string.rep(' ', vim.fn.shiftwidth())

            -- Keep the closing delimiter aligned with the opening tag.
            if line:sub(col + 1):match('^%s*/?>') then
              return '<CR><C-u>' .. indent .. '<Esc>O<C-u>' .. attribute_indent
            end

            return '<CR><C-u>' .. attribute_indent
          end
          node = node:parent()
        end

        return '<CR>'
      end, { buffer = event.buf, expr = true, desc = 'New line in HTML / JSX tags' })
    end,
  })
end

return M
