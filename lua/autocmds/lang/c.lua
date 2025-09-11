vim.api.nvim_create_autocmd('FileType', {
  desc = "Build and run the C file in the current buffer",
  pattern = 'c',
  callback = function ()
    vim.api.nvim_create_user_command("BuildRun", function ()
      vim.cmd("!cd %:h && gcc -o %:t:r %:t && ./%:t:r")
    end, {})
    require('which-key').add({
      { '<leader>c', group = 'commands' },
      { '<leader>cb', '<cmd>BuildRun<CR>', desc = 'Build and Run the C file in the current buffer' },
    })
  end,
})
