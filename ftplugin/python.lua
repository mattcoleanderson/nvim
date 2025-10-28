local wk = require('which-key')

local function paths()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == '' then
    vim.notify('No file name for current buffer.', vim.log.levels.WARN)
    return nil
  end


  -- Find git root from current file upward
  local git_root = vim.fs.root(file, { '.git' })
  if not git_root then
    vim.notify('Couldnot find .git root for: ' .. file, vim.log.levels.ERROR)
    return nil
  end

  local backend_dir = git_root .. '/tdrs-backend'

  local file_norm = file:gsub('\\','/')
  local backend_norm = backend_dir:gsub('\\', '/')

  if not file_norm:find('^' .. vim.pesc(backend_norm .. '/')) then
    -- If file is outside of tdrs-backend, then return the aboslute path
    return {
      git_root = git_root,
      backend_dir = backend_dir,
      rel_to_backend = file,
    }
  end

  local rel = file_norm:sub(#backend_norm + 2) -- strip '../tdrs-backend/'

  return {
    git_root = git_root,
    backend_dir = backend_dir,
    rel_to_backend = rel,
  }
end

local function nearest_node(rel_file)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)

  local func_name, func_indent
  local class_name

  -- Walk the file upward from cursor line
  for i = #lines, 1, -1 do
    local line = lines[i]

    if not func_name then
      local indent, fname = line:match('^([ \t]*)def%s+(test[%w_]+)%s*%(')
      if not fname then
        indent, fname = line:match('^([ \t]*)async%s+def%s+(test[%w_]+)%s*%(')
      end
      if fname then
        func_name = fname
        func_indent = #(indent or '')
      end
    else
      local cindent, cname = line:match('^([ \t]*)class%s+([Tt]est[%w_]+)%s*[:(]')
      if cname and #(cindent or '') < func_indent then
        class_name = cname
        break
      end
    end
  end

  if func_name and class_name then
    return string.format("%s::%s::%s", rel_file, class_name, func_name)
  elseif func_name then
    return string.format("%s::%s", rel_file, func_name)
  else
    return rel_file
  end
end

local function run_task(pytest_args, use_cov)
  -- Choose which Taskfile target to run
  local target = use_cov and "backend-pytest-cov" or "backend-pytest"

  -- Quote once for shell; allow spaces/colons in node ids
  local cmd = string.format([[task %s PYTEST_ARGS="%s"]], target, pytest_args)

  -- Run in a terminal so you can see output, re-run with <C-\><C-n>:buffer etc.
  -- You can swap to jobstart if you prefer detached jobs/logging.
  vim.cmd("botright split | resize 12")
  vim.cmd("terminal " .. cmd)
end

-- :PytestFile[!]
local function pytest_file(opts)
  local p = paths()
  if not p then return end

  -- We pass the path relative to tdrs-backend so it matches your Taskfile's working dir
  local pytest_args = p.rel_to_backend

  -- Add whatever default flags you want here (kept minimal)
  run_task(pytest_args, opts.bang)
end

-- :PytestNearest[!]
local function pytest_nearest(opts)
  local p = paths()
  if not p then return end

  local node = nearest_node(p.rel_to_backend)
  run_task(node, opts.bang)
end

-- User commands
vim.api.nvim_create_user_command("PytestFile", function(o)
  pytest_file(o)
end, { bang = true })

vim.api.nvim_create_user_command("PytestNearest", function(o)
  pytest_nearest(o)
end, { bang = true })

-- Keymaps (normal mode)
-- <leader>tf : file, <leader>tF : file with coverage
-- <leader>tn : nearest, <leader>tN : nearest with coverage
vim.keymap.set("n", "<localleader>f", ":PytestFile<CR>", { desc = "pytest current file" })
vim.keymap.set("n", "<localleader>F", ":PytestFile!<CR>", { desc = "pytest current file (coverage)" })
vim.keymap.set("n", "<localleader>n", ":PytestNearest<CR>", { desc = "pytest nearest test" })
vim.keymap.set("n", "<localleader>N", ":PytestNearest!<CR>", { desc = "pytest nearest test (coverage)" })

