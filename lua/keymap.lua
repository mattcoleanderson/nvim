local wk = require('which-key')
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- Core commands
vim.keymap.set('n', '<leader>q', ':conf q<CR>', { desc = 'Quit the current window. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>Q', ':conf qa<CR>', { desc = 'Exit Vim. Prompt for unsaved buffers.' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save the current buffer in window' })

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
  { '<leader>gh', ':noh<CR>', desc = 'Remove highlighting for search' },
  {
    '<leader>gz',
    function()
      if vim.wo.foldmethod == 'manual' then
        vim.wo.foldmethod = 'expr'
        -- Restore LSP folds if available, otherwise treesitter
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local has_lsp_folds = false
        for _, client in ipairs(clients) do
          if client:supports_method('textDocument/foldingRange') then
            has_lsp_folds = true
            break
          end
        end
        vim.wo.foldexpr = has_lsp_folds and 'v:lua.vim.lsp.foldexpr()' or 'v:lua.vim.treesitter.foldexpr()'
        vim.notify('Folds: ' .. (has_lsp_folds and 'LSP' or 'treesitter'))
      else
        vim.wo.foldmethod = 'manual'
        vim.notify('Folds: manual')
      end
    end,
    desc = 'Toggle fold method (expr/manual)',
  },
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
  {
    '<leader>gdp',
    function()
      local lines = vim.fn.getreg('+', 1, true)
      local filetype = vim.bo.filetype

      vim.cmd('tab split')
      local source_window = vim.api.nvim_get_current_win()
      vim.cmd('diffthis')
      vim.cmd('rightbelow vnew')
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'wipe'
      vim.bo.swapfile = false
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.bo.filetype = filetype
      vim.bo.modified = false
      vim.bo.modifiable = false
      vim.cmd('diffthis')
      vim.api.nvim_set_current_win(source_window)
    end,
    desc = 'Diff current buffer against clipboard',
  },
  { '<leader>gdc', '<cmd>windo bd!<cr>', desc = 'Close diff buffer (doesn\'t save)' },
})

-- Search Commands
wk.add({
  { '<leader>f', group = 'find', mode = 'nv' },
  { '<leader>fr', 'y:%s/<C-r>"//gc<left><left><left>', mode = 'v', desc = 'Search and Replace selected text' },
})
