local min_severity = { severity = { min = vim.diagnostic.severity.WARN } }

vim.diagnostic.config {
  virtual_text = min_severity,
  underline = min_severity,
  signs = min_severity,
  float = min_severity,
}

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer

    vim.lsp.enable('bashls')
    vim.lsp.enable('clangd')
    vim.lsp.enable('denols')
    vim.lsp.enable('gopls')
    vim.lsp.enable('just')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('ruby_lsp')
    vim.lsp.enable('taplo')
    vim.lsp.enable('ty')
    vim.lsp.enable('zls')
end}
