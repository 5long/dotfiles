return {
  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.edge_transparent_background = true
      vim.g.edge_better_performance = true
      vim.g.edge_disable_italic_comment = true
      vim.cmd([[colorscheme edge]])
    end,
  },

  'tpope/vim-abolish',
  'tpope/vim-unimpaired',
  'famiu/bufdelete.nvim',

  {
    "pianocomposer321/officer.nvim",
    dependencies = "stevearc/overseer.nvim",
    config = function()
      require("officer").setup {
        create_mappings = true,
      }
    end,
  },

  { 'numToStr/Comment.nvim',  opts = {} },
  { 'windwp/nvim-autopairs',  opts = {} },
  { 'kylechui/nvim-surround', version = "*", opts = {} },
  { 'https://codeberg.org/andyg/leap.nvim.git' },
  { 'lotabout/skim.vim',      lazy = false },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      theme = 'edge',
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = { 'filetype' }
      },
    },
  },
  'tpope/vim-eunuch',
  'justinmk/vim-dirvish',
  '5long/ragain',
  {
    'L3MON4D3/LuaSnip',
    version = "v1.*",
    dependencies = 'honza/vim-snippets',
    config = function()
      require("luasnip").setup({})
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
  'honza/vim-snippets',
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
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
  },
}
