vim.cmd [[packadd packer.nvim]]

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
end)
