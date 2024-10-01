-- For custom filetype detection

-- The following filetype will use the extension before `.symlink` as the file type
-- For example, `test.yml.symlink` will be treated as `test.yml`
vim.filetype.add({
  extension = {
    symlink = function (path, bufnr)
      return vim.filetype.match({ buf = bufnr, filename = path:gsub('%.symlink$', '') })
    end
  }
})
