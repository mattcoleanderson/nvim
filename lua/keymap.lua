local wk = require('which-key')
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- Core commands
vim.keymap.set('n', '<leader>q', ':conf q<CR>', { desc = 'Quit the current window. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>Q', ':conf qa<CR>', { desc = 'Exit Vim. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save the current buffer in window' })
vim.keymap.set('n', '<leader>h', ':noh<CR>', { desc = 'Remove highlighting for search' })

-- Windows
-- if you would like to add more window commands type `:h CTRL-W`
wk.add({
  { '<leader>w', proxy = '<c-w>',                                group = 'window' }, -- proxy to window mappings
  { '<c-w>c',    desc = 'Close window' },
  { '<c-w>H',    desc = 'move current window to the far left' },
  { '<c-w>J',    desc = 'move current window to the very bottom' },
  { '<c-w>K',    desc = 'move current window to the very top' },
  { '<c-w>L',    desc = 'move current window to the far right' },
})

-- Custom Commands
wk.add({
  { '<leader>g', group = 'other' }, -- A catch all for commands without a group
})
vim.keymap.set('n', '<leader>gc', ':ToggleConcealLevel<CR>', { desc = 'Change conceal level between 2 and 0' })
