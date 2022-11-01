vim.cmd [[packadd packer.nvim]]

-- LSP Mappings.
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

vim.diagnostic.config {
  virtual_text = min_severity,
  underline = min_severity,
  signs = min_severity,
  float = min_severity,
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Colorz!
  use 'sainnhe/edge'

  use 'vim-scripts/ReplaceWithRegister'
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
  use {'nvim-lualine/lualine.nvim', config = function()
    require('lualine').setup {
      theme = 'edge',
      options ={
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'location'},
        lualine_z = {'filetype'}
      },
    }
  end}
  use 'tpope/vim-eunuch'
  use 'justinmk/vim-dirvish'

  use '5long/ragain'
  use { 'L3MON4D3/LuaSnip',
    tag = 'v1.*',
    requires = 'honza/vim-snippets',
    config = function()
      require("luasnip").setup({})
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  }
  use 'honza/vim-snippets'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        textobjects = { enable = true },
        indent = { enable = true },
      })
    end,
  }

  use {'neovim/nvim-lspconfig', config = function()
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
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, bufopts)
    end

    local lsp = require('lspconfig')
    lsp['pyright'].setup{
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

    lsp['solargraph'].setup{
      on_attach = on_attach,
    }
  end}

  use({ "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  local null_ls = require("null-ls")

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    sources = {
      null_ls.builtins.completion.luasnip,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.yamllint,
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
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end,
  })
end)
