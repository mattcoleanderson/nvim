# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Neovim configuration using lazy.nvim as the plugin manager.

## Architecture

### Loading order (init.lua)

1. Bootstrap lazy.nvim
2. Set leaders: `<Space>` (leader), `,` (localleader)
3. `options` — vim options
4. `toggle-plugins` — centralized plugin enable/disable flags (`vim.g.plugins`)
5. `lazy.setup('plugins')` — loads all plugin specs
6. `commands` — custom user commands
7. `keymap` — core keybindings (loaded last so which-key is available)
8. `filetype` — custom filetype detection
9. Set colorscheme from `vim.g.colorscheme`

### Plugin organization

Plugins live in `lua/plugins/` and are imported by category via `lua/plugins/init.lua`:
- `dap`, `dap.lang` — debugger configs
- `explorers` — neotree, aerial
- `git` — gitsigns, lazygit, diffview
- `lang`, `lang.*` — language-specific (vimtex, obsidian, markview, C#, HTML, Lua, markdown)
- `lsp` — mason, nvim-lspconfig, none-ls (formatters), nvim-lint
- `sessions`, `signs`, `snippets` — auto-session, marks, coverage, LuaSnip, nvim-cmp

### Plugin toggle system

`lua/toggle-plugins.lua` defines a `vim.g.plugins` table mapping plugin keys to booleans. Each plugin spec references this table in its `enabled` field, allowing centralized control over which plugins load.

### LSP setup

Uses Neovim 0.11+ builtin LSP config pattern (`vim.lsp.config` / `vim.lsp.enable`). Per-language server configs live in `lua/plugins/lsp/lang/*.lua`. Formatters go through none-ls; linters through nvim-lint.

### Filetype plugins

`ftplugin/` contains per-filetype configs (C, Python) with custom commands and keybindings using localleader (`,`). These define build/run commands, test runners, etc.

### Keybinding conventions

All core bindings use which-key with `<leader>` prefixes organized by function:
- `b` buffers, `e` explorer, `f` find/telescope, `l` LSP, `v` git, `w` windows, `x` diagnostics
- `c` is reserved for filetype-specific commands (set in ftplugin files)
- Filetype-specific bindings use localleader `,`

## Commands

```sh
# Format Lua files (config in stylua.toml)
stylua lua/

# Check lazy.nvim plugin health inside Neovim
:checkhealth lazy

# Update plugins (updates lazy-lock.json)
:Lazy update

# Sync plugins to match lazy-lock.json
:Lazy sync
```
