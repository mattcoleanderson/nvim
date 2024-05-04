local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {}) -- Search all project files
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})  -- Search git files
