local wk = require('which-key')
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- Core commands
vim.keymap.set('n', '<leader>q', ':conf q<CR>', { desc = 'Quit the current window. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>Q', ':conf qa<CR>', { desc = 'Exit Vim. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save the current buffer in window' })
vim.keymap.set('n', '<leader>h', ':noh<CR>', { desc = 'Remove highlighting for search' })

-- Clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Put from clipbaord' })

vim.keymap.set('n', '<leader>/', ':normal gcc<CR><DOWN>', { desc = '[/] Toggle comment line' })
-- <Esc> - exists visual mode.
-- :normal executes keystrokes in normal mode.
-- gv - restores selection.
-- gc - toggles comment
-- <CR> sends the command
vim.keymap.set('v', '<leader>/', '<Esc>:normal gvgc<CR>', { desc = '[/] Toggle comment block' })

-- Windows
-- if you would like to add more window commands type `:h CTRL-W`
wk.add({
  { '<leader>w', proxy = '<c-w>', group = 'window' }, -- proxy to window mappings

  -- TODO: Create an autocommand to detect layout so this can be reduced to a single keymap
  { '<leader>wt', group = 'toggle layout' },
  { '<leader>wtv', '<c-w>t<c-w>H', desc = 'Switch to vertical split' },
  { '<leader>wth', '<c-w>t<c-w>K', desc = 'Switch to horizontal split' },

  { '<leader>wc', '<c-w>c', desc = 'Close window' },
  { '<leader>wH', '<c-w>H', desc = 'move current window to the far left' },
  { '<leader>wJ', '<c-w>J', desc = 'move current window to the very bottom' },
  { '<leader>wK', '<c-w>K', desc = 'move current window to the very top' },
  { '<leader>wL', '<c-w>L', desc = 'move current window to the far right' },

  { '<leader>wf', '<c-w>|<c-w>_', desc = 'Max out current window size' },
})

-- Custom Commands
wk.add({
  { '<leader>g', group = 'other' }, -- A catch all for commands without a group
  { '<leader>gc', '<cmd>ToggleConcealLevel<CR>', desc = 'Change conceal level between 2 and 0' },
  { '<leader>ga', '<cmd>ToggleAutoComplete<CR>', desc = 'Toggle CMP autocomplete on and off' },
})

-- Buffer Commands
wk.add({
  { '<leader>b', group = 'buffers' },

  -- Navigate buffers
  { '<leader>bh', '<cmd>BufferLineCyclePrev<CR>', desc = 'Navigate to next buffer' },
  { '<leader>bl', '<cmd>BufferLineCycleNext<CR>', desc = 'Navigate to previous buffer' },
  { 'H', '<cmd>BufferLineCyclePrev<CR>', desc = 'Navigate to next buffer' },
  { 'L', '<cmd>BufferLineCycleNext<CR>', desc = 'Navigate to previous buffer' },

  { '<leader>bf', '<cmd>BufferLinePick<CR>', desc = 'Pick buffer to switch to' },

  -- Close buffers
  { '<leader>bc', group = 'Close buffer commands' },
  { '<leader>bcc', '<cmd>CloseCurrentBuffer<CR>', desc = 'Close curent buffer' },
  { '<leader>bca', '<cmd>windo bd<CR>', desc = 'Close all buffers in current window' },
  { '<leader>bcf', '<cmd>BufferLinePickClose<CR>', desc = 'Pick buffer to close' },
  { '<leader>bch', '<cmd>BufferLineCloseLeft<CR>', desc = 'Close all buffers to the left' },
  { '<leader>bcl', '<cmd>BufferLineCloseRight<CR>', desc = 'Close all buffers to the right' },
  { '<leader>bco', '<cmd>BufferLineCloseOthers<CR>', desc = 'Close all other buffers' },
  { '<leader>bcg', '<cmd>BufferLineGroupClose<CR>', desc = 'Close Buffer Group' },

  -- Other
  { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin buffer' },
})

-- Diff Commands
wk.add({
  { '<leader>gd', group = 'diffs' },
  { '<leader>gdd', '<cmd>tabnew | vnew | windo diffthis | wincmd h<CR>', desc = 'Open empty diff buffer' },
  { '<leader>gdc', '<cmd>windo bd!<cr>', desc = 'Close diff buffer (doesn\'t save)' },
})

-- Search Commands
wk.add({
  { '<leader>f', group = 'find', mode = 'nv' },
  { '<leader>fr', 'y:%s/<C-r>"//gc<left><left><left>', mode = 'v', desc = 'Search and Replace selected text' },
})

