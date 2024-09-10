return {
  {
    'max397574/better-escape.nvim',
    main = 'better_escape',
    opts = {
      default_mappings = false,
      mappings = {
        -- insert mode
        i = {
          j = { -- first key
            j = '<Esc>', -- second key
          },
        },
        -- command mode
        c = {
          j = {
            j = '<Esc>',
          },
        },
        -- terminal mode
        t = {
          [','] = {
            [','] = '<C-\\><C-n>',
          };
        },
        -- visual mode
        v = {
          [','] = {
            [','] = '<Esc>',
          },
        },
        -- select mode
        s = {
          j = {
            j = '<Esc>',
          },
        },
      },
    },
  },
}
