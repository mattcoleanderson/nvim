-- Lua Language Server configuration
return {
  on_attach = function(client, _)
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
    client.server_capabilities.documentFormattingProvider = false -- turn off lsp formatting, want to use none_ls instead
  end,
}
