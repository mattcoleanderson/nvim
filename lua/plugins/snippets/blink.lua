local M = {
  'saghen/blink.cmp',
  enabled = vim.g.plugins.blink_cmp,
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'super-tab', -- tab to accept
      -- C-e: Hide menu
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-k: Toggle signature help (if signature.enabled = true)
      -- C-b/C-f: Scroll up/down documentation

      -- Custom Keymaps --------------------------------------------------------

      -- Open menu or open docs if already open
      --     default is C-space, but I use C-space as my tmux prefix
      ['<M-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      accept = { auto_brackets = { enabled = false } },
      documentation = { auto_show = true },
    },
    signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100, -- show at higher priority than LSP
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}

return M
