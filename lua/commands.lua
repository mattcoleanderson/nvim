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
  desc = "Toggle conceal level vim option between 2 and 0.",
})
