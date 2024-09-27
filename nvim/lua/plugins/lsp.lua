local opts = { noremap=true, silent=true }
local min_severity = { severity = { min = vim.diagnostic.severity.WARN } }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev(min_severity)
  end, opts)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next(min_severity)
  end, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>rf', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

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

    local lsp = require('lspconfig')

    lsp.pyright.setup{
      settings = {
        pyright = {
          venvPath = '~/.virtualenvs',
          analysis = {
            diagnosticSeverityOverrides = {
              reportUnusedImport = 'warning',
              reportUnusedClass = 'warning',
              reportUnusedFunction = 'warning',
              reportUnusedVariable = 'warning',
            },
          },
        },
      }
    }

    lsp.solargraph.setup({})
    lsp.rust_analyzer.setup({})
    lsp.bashls.setup({})
    lsp.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        }
      }
    }
end}
