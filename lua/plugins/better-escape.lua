return {
  {
    'max397574/better-escape.nvim',
    main = 'better_escape',
    opts = {
      default_mappings = false,
      mappings = {
        i = { -- insert mode
          j = { -- first key
            j = '<Esc>', -- second key
          },
        },
        c = { --command mode
          j = {
            j = '<Esc>',
          },
        },
        t = {
          j = {
            j = '<C-\\><C-n>',
          },
        },
        v = {
          j = {
            j = '<Esc>',
          },
        },
        s = {
          j = {
            j = '<Esc>',
          },
        },
      },
    },
  },
}
