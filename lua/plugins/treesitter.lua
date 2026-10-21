local M = {
  'nvim-treesitter/nvim-treesitter',
  enabled = vim.g.plugins.treesitter,
  lazy = false,
  build = ':TSUpdate',
  dependencies = { 'OXY2DEV/markview.nvim' },
}

M.config = function()
  local treesitter = require('nvim-treesitter')
  local installs = {}

  local function enable_highlighting(event)
    if vim.api.nvim_buf_is_valid(event.buf) and vim.bo[event.buf].filetype == event.match then
      pcall(vim.treesitter.start, event.buf)
    end
  end

  local function install_parser(event)
    local lang = vim.treesitter.language.get_lang(event.match)
    if not lang then
      return
    end

    local ok, loaded = pcall(vim.treesitter.language.add, lang)
    if ok and loaded then
      return
    end

    if vim.list_contains(treesitter.get_available(), lang) then
      -- Share pending installs across buffers using the same language.
      if not installs[lang] then
        installs[lang] = treesitter.install({ lang })
        installs[lang]:await(vim.schedule_wrap(function(err, success)
          if not err and success then
            vim.notify('Installed parser: ' .. lang, vim.log.levels.INFO, { title = 'Tree-sitter' })
          end
        end))
      end
      installs[lang]:await(vim.schedule_wrap(function(err)
        installs[lang] = nil
        if not err then
          enable_highlighting(event)
        end
      end))
    end
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
    desc = 'Enable Tree-sitter highlighting for installed parsers',
    callback = enable_highlighting,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TreesitterAutoInstall', { clear = true }),
    desc = 'Install missing Tree-sitter parsers',
    callback = install_parser,
  })
end

return M
