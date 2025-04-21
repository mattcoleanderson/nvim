-- Change conceal level between 2 and 0
local function ToggleConcealLevel()
  local conceallevel = vim.opt.conceallevel:get()

  if conceallevel == 0 then
    conceallevel = 2
  else
    conceallevel = 0
  end

  vim.opt.conceallevel = conceallevel
  print(vim.opt.conceallevel:get())
end

vim.api.nvim_create_user_command('ToggleConcealLevel', ToggleConcealLevel, {
  desc = 'Toggle conceal level vim option between 2 and 0.',
})

-- Toggle nvim-cmp autocomplete
local function ToggleAutoComplete()
  local cmp = require('cmp')

  cmp.setup({
    enabled = not cmp.get_config().enabled,
  })

  print('Autocomplete: ' .. (cmp.get_config().enabled and 'ON' or 'OFF'))
end

vim.api.nvim_create_user_command('ToggleAutoComplete', ToggleAutoComplete, {
  desc = 'Toggle cmp autocomplete on and off'
})

-- Close current buffer without closing window
-- switches to the buffer to the left otherwise right otherwise opens a new buffer
local function CloseCurrentBuffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })

  -- Get all listed buffers except the current one
  local next_buf
  for i, buf in ipairs(listed) do
    if buf.bufnr == bufnr then
      local next_entry = listed[i + 1] or listed[i - 1] -- one of the following in order if available: next buffer, prev buffer, nil
      next_buf = next_entry and next_entry.bufnr        -- sets next buf based off next_entry
    end
  end

  -- Switch to the next buffer
  if next_buf then
    vim.api.nvim_set_current_buf(next_buf)
  else
    -- Open a new empty buffer if no others exist
    vim.cmd('enew')
  end

  -- Delete the original buffer
  vim.api.nvim_buf_delete(bufnr, { force = false })
end

vim.api.nvim_create_user_command('CloseCurrentBuffer', CloseCurrentBuffer, {
  desc = 'Closes the current buffer without closing the window. The replacement buffer will be one of the following in order: next buffer, previous buffer, new empty buffer'
})

