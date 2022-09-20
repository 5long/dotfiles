vim.cmd [[packadd packer.nvim]]

-- LSP Mappings.
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Colorz!
  use {'NLKNguyen/papercolor-theme', opt = true}

  use '5long/ryve'
  use 'tpope/vim-abolish'
  use 'tpope/vim-unimpaired'

  use {'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end}

  use {'windwp/nvim-autopairs', config = function()
    require("nvim-autopairs").setup {}
  end}

  use {'machakann/vim-sandwich', config = function()
    vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
  end}

  use 'junegunn/fzf.vim'
  use '5long/vim-imtoggle'
  use 'itchyny/lightline.vim'
  use 'tpope/vim-eunuch'
  use 'justinmk/vim-dirvish'

  use '5long/ragain'
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use {'neomake/neomake', opt = true, config = function()
    vim.cmd "call neomake#configure#automake('rw', 1000)"
  end}
  use '5long/sw-makers'

  use 'sheerun/vim-polyglot'

  use {'neovim/nvim-lspconfig', tag = 'v0.1.3', config = function()
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end

  require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
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
        }
      },
    }
  }
end}

  use({ "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  local null_ls = require("null-ls")

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
      },
      on_attach = function(client, bufnr)
          if not client.supports_method("textDocument/formatting") then
            return
          end

          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  vim.lsp.buf.formatting_sync()
              end,
          })
      end,
    })
end)
