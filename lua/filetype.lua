-- For custom filetype detection
-- https://neovim.discourse.group/t/how-to-add-custom-filetype-detection-to-various-env-files/4272/2

vim.filetype.add({
  extension = {
    -- The following filetype will use the extension before `.symlink` as the file type
    -- For example, `test.yml.symlink` will be treated as `test.yml`
    symlink = function(path, bufnr)
      return vim.filetype.match({ buf = bufnr, filename = path:gsub('%.symlink$', '') })
    end,
    zsh = 'sh', -- zsh has poor lsp and treesitter support. Its better to treat it as bash
    sh = 'sh',  -- this will ensure that sh files with a zsh shebang are still treated as bash
  },
  filename = {
    ['.zshrc'] = 'sh',
    ['.zshenv'] = 'sh',
  },
})
