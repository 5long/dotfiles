vim.cmd.packadd('nvim.undotree')

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

  { 'windwp/nvim-autopairs',  opts = {} },
  { 'kylechui/nvim-surround', version = "*", opts = {} },
  { 'https://codeberg.org/andyg/leap.nvim.git' },
  { 'junegunn/fzf.vim', lazy = false },
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
  -- '5long/imdi.nvim',
  {
    dir = "~/src/imdi.nvim",
  },
}
