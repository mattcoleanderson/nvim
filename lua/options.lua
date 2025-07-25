--[[
There are many ways to set vim options including:
  vim.cmd('set wrap')
  vim.opt.wrap = false
  vim.o.wrap = false
]]

-- TODO: create a better winbar suited to my needs, also update the statu line (lualine plugin) as well
local function status_line()
  local mode = '%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}'
  local file_name = '%-.16t'
  local buf_nr = '[%n]'
  local modified = ' %-m'
  local file_type = ' %y'
  local right_align = '%='
  local line_no = '%10([%l/%L%)]'
  local pct_thru_file = '%5p%%'

  return string.format(
    '%s%s%s%s%s%s%s%s',
    mode,
    file_name,
    buf_nr,
    modified,
    file_type,
    right_align,
    line_no,
    pct_thru_file
  )
end

-- Set all vim options in this table
local options = {
  number = true, -- Show absolute line numbers
  relativenumber = true, -- Show relative line numbers
  expandtab = true,
  tabstop = 4,
  softtabstop = 2,
  shiftwidth = 2,
  wrap = false,
  conceallevel = 2,
  signcolumn = 'auto:3', -- Allows the signcolumn (gutter) to display up to X signs per line
  laststatus = 3,
  -- winborder = 'single', -- adds border to floating windows
  winbar = status_line(),
}

-- The above table will be iterated to set options individually
for option, value in pairs(options) do
  vim.opt[option] = value
end
