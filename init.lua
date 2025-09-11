--plugins, opts) Bootstrap Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set Map leader
vim.keymap.set('n', '<Space>', '<Nop>') -- remap space to nothing so hitting space doesn't move the cursore to the left by 1
vim.g.mapleader = ' ' -- remap leader to space
-- Set Map Local Leader
vim.g.maplocalleader = ',' -- remap localleaer to backspace

-- Run all other lua files
require('options')
require('toggle-plugins')
require('lazy').setup('plugins') -- top-level files in lua/plugins will be auto-required
require('autocmds')
require('commands')
require('keymap') -- ran last so which-key can be used, might create a second file for which-key mappings
require('filetype')

vim.cmd.colorscheme(vim.g.colorscheme)
