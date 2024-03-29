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

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Colorz!
  use 'sainnhe/edge'

  use 'vim-scripts/ReplaceWithRegister'
  use 'tpope/vim-abolish'
  use 'tpope/vim-unimpaired'
  use 'famiu/bufdelete.nvim'

  use {'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end}

  use {'windwp/nvim-autopairs', config = function()
    require("nvim-autopairs").setup {}
  end}

  use {'kylechui/nvim-surround', tag = "*", config = function()
    require('nvim-surround').setup({})
  end}

  use {'ggandor/leap.nvim', config = function()
    require('leap').add_default_mappings()
  end}

  use { "5long/imdi.nvim", rocks = 'dbus_proxy' }
  use 'lotabout/skim.vim'
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
          }
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
end)
