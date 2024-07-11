-- Set Map leader
vim.keymap.set('n', '<Space>', '<Nop>') -- remap space to nothing so hitting space doesn't move the cursore to the left by 1
vim.g.mapleader = ' ' -- remap mapleader to space

-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- Core commands
vim.keymap.set('n', '<leader>q', ':conf q<CR>', { desc = 'Quit the current window. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>Q', ':conf qa<CR>', { desc = 'Exit Vim. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save the current buffer in window' })

-- Windows
vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'Access Window commands' })

-- Custom Commands
vim.keymap.set('n', '<leader>c', ':ToggleConcealLevel<CR>', { desc = 'Change conceal level between 2 and 0' })
