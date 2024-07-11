--[[
There are many ways to set vim options including:
  vim.cmd('set wrap')
  vim.opt.wrap = false
  vim.o.wrap = false
]]


-- Set all vim options in this table
local options = {
  number = true,          -- Show absolute line numbers
  relativenumber = true,  -- Show relative line numbers
  expandtab = true,
  tabstop = 4,
  softtabstop = 2,
  shiftwidth = 2,
  wrap = false,
  conceallevel = 2,
}

-- The above table will be iterated to set options individually
for option, value in pairs(options) do
  vim.opt[option] = value
end
