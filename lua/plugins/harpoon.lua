local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}

M.config = function()
  local harpoon = require('harpoon')

  harpoon:setup()
  -- Below I will document features I would like to add to my config:
  -- TODO: Create a new list
  -- TODO: Add current buffer to an existing list, if doesn't exist, create list then add buffer to it
  -- TODO: Remove buffer from a specified list
  -- TODO: Delete specified list
  -- TODO: Add a variable to track the currently toggled list to quickly run commands on without specifying a list
  -- TODO: Activate a list
  -- TODO: Add split windows to a list, including the buffers currently opened in them
  -- TODO: Open all buffers in a list
  -- TODO: Close all buffers and open all buffers in a list

  -- Define Keymaps
  local wk = require('which-key')
  wk.add({
    { '<leader>h', group = 'harpoon' },
    { '<leader>hc', function() harpoon:list():add() end, desc = 'Add current buffer to list' },
    { '<leader>ha', function() harpoon:list():append() end, desc = 'Append current buffer to current list' },
    { '<leader>hm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'Toggle harpoon menu' },

    { '<leader>h1', function() harpoon:list():select(1) end, desc = 'Go to buffer in Harpoon list 1' },
    { '<leader>h2', function() harpoon:list():select(2) end, desc = 'Go to buffer in Harpoon list 2' },
    { '<leader>h3', function() harpoon:list():select(3) end, desc = 'Go to buffer in Harpoon list 3' },
    { '<leader>h4', function() harpoon:list():select(4) end, desc = 'Go to buffer in Harpoon list 4' },

    { '<leader>hn', function() harpoon:list():next() end, desc = 'Go to next buffer in Harpoon list' },
    { '<leader>hp', function() harpoon:list():prev() end, desc = 'Go to prev buffer in Harpoon list' },
  })

  -- Telescope Configuration
  local telescope_config = require('telescope.config').values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require('telescope.pickers')
      .new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = telescope_config.file_previewer({}),
        sorter = telescope_config.generic_sorter({}),
      })
      :find()
  end

  wk.add({'<leader>he', function() toggle_telescope(harpoon:list()) end, desc = 'Toggle harpoon telescope'})
end

return M
