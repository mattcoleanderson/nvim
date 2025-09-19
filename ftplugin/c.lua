local wk = require('which-key')

-- Create User Commands
local commands = {
  {
    name = 'BuildRun',
    rhs = function() vim.cmd('!cd %:h && gcc -o %:t:r %:t && ./%:t:r') end,
    desc = 'Build and run the C file in the currnet buffer',
    keys = { mapping = '<leader>cb', desc = "Build & Run" },
  },
  {
    name = 'FindInMan',
    rhs = function ()
      local cword = vim.fn.expand('<cword>')

      local _ = vim.fn.system({ 'man', '-w', '-a', cword })
      if vim.v.shell_error ~= 0 then
        vim.notify('No manual entry for ' .. cword, vim.log.levels.ERROR)
        return
      end

      local bufnr = vim.api.nvim_create_buf(false, true)

      --- open floating win
      local width = math.floor(vim.o.columns * 0.6)
      local height = math.floor(vim.o.lines * 0.6)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
        title = ' man ' .. cword .. ' ',
      })
      vim.cmd('hide Man ' .. cword)
      vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })
    end,
    desc = 'Display Man page for word under cursor',
    keys = { mapping = 'K', desc = 'Display Man page for word under cursor' },
  },
}

for _, cmd in ipairs(commands) do
  vim.api.nvim_create_user_command(cmd.name, cmd.rhs, { desc = cmd.desc })

  if cmd.keys then
    wk.add({
      { '<leader>c',  group = 'commands' },
      { cmd.keys.mapping, '<cmd>' .. cmd.name .. '<CR>', desc = cmd.keys.desc },
    })
  end
end

