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

-- Singleton pytest terminal (jobstart + {term=true})
local PYTEST_TERM = { win = nil, buf = nil, job = nil }

local function open_or_reuse_win(height)
  if PYTEST_TERM.win and vim.api.nvim_win_is_valid(PYTEST_TERM.win) then
    vim.api.nvim_set_current_win(PYTEST_TERM.win)
  else
    vim.cmd(("botright split | resize %d"):format(height or 12))
    PYTEST_TERM.win = vim.api.nvim_get_current_win()
  end
end

local function prepare_buf()
  -- Create new scratch buffer and set to PYTEST_TERM.win
  --    must be done first, or deleting old buffer could close window
  local newbuf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(PYTEST_TERM.win, newbuf)

  -- Delete old buffer
  if PYTEST_TERM.buf and vim.api.nvim_buf_is_valid(PYTEST_TERM.buf) then
    pcall(vim.api.nvim_buf_delete, PYTEST_TERM.buf, { force = true })
  end

  PYTEST_TERM.buf = newbuf
  vim.bo[PYTEST_TERM.buf].bufhidden = "wipe"
  vim.bo[PYTEST_TERM.buf].filetype = "pytest-output"
end

local function stop_old_job()
  if PYTEST_TERM.job and vim.fn.jobwait({ PYTEST_TERM.job }, 0)[1] == -1 then
    pcall(vim.fn.jobstop, PYTEST_TERM.job)
  end
  PYTEST_TERM.job = nil
end

local function run_in_pytest_term(cmd, opts)
  opts = opts or {}
  open_or_reuse_win(opts.height or 12)

  -- ensure we don't leave old jobs/buffers around
  stop_old_job()
  prepare_buf()


  -- run the job as a terminal in THIS window/buffer
  -- use a shell so we can pass a string command
  PYTEST_TERM.job = vim.fn.jobstart({ "sh", "-c", cmd }, {
    term = true,  -- <<<< this replaces termopen()
    on_exit = function(_, code, _)
      if opts.close_on_success and code == 0 then
        vim.schedule(function()
          if PYTEST_TERM.win and vim.api.nvim_win_is_valid(PYTEST_TERM.win) then
            pcall(vim.api.nvim_win_close, PYTEST_TERM.win, true)
          end
        end)
      end
    end,
  })

  -- convenience: 'q' closes the pytest window
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = PYTEST_TERM.buff, desc = "Terminal -> Normal mode" })
  vim.keymap.set("n", "q", function()
    if PYTEST_TERM.win and vim.api.nvim_win_is_valid(PYTEST_TERM.win) then
      vim.api.nvim_win_close(PYTEST_TERM.win, true)
    end
  end, { buffer = PYTEST_TERM.buf, desc = "close pytest terminal" })

  -- Autoscroll by default; press <Esc> to leave insert/terminal-mode any time
  vim.cmd("startinsert")
end

local function run_task(pytest_args, use_cov)
  -- Choose which Taskfile target to run
  local target = use_cov and "backend-pytest-cov" or "backend-pytest"

  -- Quote once for shell; allow spaces/colons in node ids
  local cmd = string.format([[task %s PYTEST_ARGS="%s"]], target, pytest_args)

  run_in_pytest_term(cmd, {
    height = 12,
    close_on_success = false,
  })
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

