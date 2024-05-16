-- Set Map leader
vim.keymap.set('n', '<Space>', '<Nop>') -- remap space to nothing so hitting space doesn't move the cursore to the left by 1
vim.g.mapleader = ' '                   -- remap mapleader to space

-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- Core commands
vim.keymap.set('n', '<leader>q', ':q<CR>') -- Quit
vim.keymap.set('n', '<leader>s', ':w<CR>') -- Save

-- Windows
vim.keymap.set('n', '<leader>w', '<C-w>') -- Windows now accessed with leader-w
