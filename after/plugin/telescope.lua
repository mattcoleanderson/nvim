local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Search all project files
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})  -- Search git files
