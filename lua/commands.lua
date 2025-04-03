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

