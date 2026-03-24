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
    -- On Arch Linux I don't have latest clang installed.
    -- Instead it's a dependency of zig which is clang20 for now.
    vim.lsp.config('clangd', {
      cmd = {
        '/usr/lib/llvm20/bin/clangd'
      },
    })

    vim.lsp.config('ruby_lsp', {
      cmd_env = { RUBYOPT = '--jit --enable=frozen-string-literal' },
      init_options = {
        linters = {'rubocop', 'standard'},
        formatter = 'standard',
        experimentalFeaturesEnabled = true,
      },
    })

    vim.lsp.enable('ansiblels')
    vim.lsp.enable('bashls')
    vim.lsp.enable('clangd')
    vim.lsp.enable('denols')
    vim.lsp.enable('gopls')
    vim.lsp.enable('just')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('ruby_lsp')
    vim.lsp.enable('systemd_lsp')
    vim.lsp.enable('taplo')
    vim.lsp.enable('terraformls')
    vim.lsp.enable('typos_lsp')
    vim.lsp.enable('ty')
    vim.lsp.enable('zls')
end}
