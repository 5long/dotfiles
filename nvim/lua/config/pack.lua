-- Neovim's native plugin manager since 0.12

vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nohlsearch')

vim.pack.add({
  'https://github.com/5long/imdi.nvim',
  'https://github.com/5long/ragain',
  'https://github.com/dcampos/nvim-snippy',
  'https://github.com/famiu/bufdelete.nvim',
  'https://github.com/junegunn/fzf.vim',
  'https://github.com/justinmk/vim-dirvish',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/sainnhe/edge',
  'https://github.com/tpope/vim-abolish',
  'https://github.com/tpope/vim-endwise',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/yorickpeterse/nvim-jump',
})

-- edge color scheme
vim.g.edge_transparent_background = true
vim.g.edge_better_performance = true
vim.g.edge_disable_italic_comment = true
vim.cmd.colorscheme 'edge'

-- jump
vim.keymap.set({ 'n', 'x', 'o' }, 's', require('jump').start, {})

-- lualine
require('lualine').setup({
  options = {
    theme = 'edge',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {
      {'diagnostics',
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      },
      { vim.ui.progress_status },
    },
    lualine_x = {},
    lualine_y = { 'location' },
    lualine_z = { 'filetype' }
  },
})

-- nvim-snippy
local map = vim.keymap.set
local snippy = require "snippy"

map({ 'i', 's' }, '<Tab>', function()
    return snippy.can_expand_or_advance() and '<Plug>(snippy-expand-or-advance)' or '<Tab>'
end, { expr = true })
map({ 'i', 's' }, '<S-Tab>', function()
    return snippy.can_jump(-1) and '<Plug>(snippy-previous)' or '<S-Tab>'
end, { expr = true })
map('x', '<Tab>', '<Plug>(snippy-cut-text)')

-- big plugins with their own file
require('config.lsp')
require('config.treeshitter')
