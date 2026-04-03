local min_severity = { severity = { min = vim.diagnostic.severity.WARN } }

vim.diagnostic.config {
  virtual_text = min_severity,
  signs = min_severity,
}

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

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

vim.lsp.enable({
  'ansiblels',
  'bashls',
  'clangd',
  'denols',
  'gopls',
  'just',
  'lua_ls',
  'ruby_lsp',
  'systemd_lsp',
  'taplo',
  'tofu_ls',
  'ty',
  'typos_lsp',
  'zls',
})
