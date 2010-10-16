let mapleader=","

" Interface
colorscheme lucius

if has('gui_gtk2')
  set guifont=DejaVu\ Sans\ Mono\ 13
  set guifontwide=WenQuanYi\ Zen\ Hei\ Mono\ 13
else
  set guifont=Consolas:h12
endif

" Windows

set switchbuf=usetab
set showtabline=2

set nocompatible
set history=300
set showcmd
set ruler
set cmdheight=2
set scrolloff=6

set cursorcolumn cursorline
set ignorecase
set incsearch
set hlsearch
noremap / /\v
set backspace=eol,start,indent

" Status Line
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c:

function! CurDir()
  let curdir = substitute(getcwd(),'/home/whyme/',"~/","g")
  return curdir
endfunction

if has("gui_running")
  set guioptions=aeicMRL
else
  set t_Co=256
endif

" Filehandle

set wildmenu
set autoread
set nobackup
set hidden
set directory-=.
set directory+=~/.tmp
autocmd! BufWritePost .vimrc source ~/.vimrc
autocmd! FocusLost * wall

nnoremap <leader>au :autocmd  <buffer><space><s-left><left>
nnoremap <leader>w :update<CR>
nnoremap <leader>dd :bdelete<CR>
nnoremap <leader>s :e ~/.vim/snippets/
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>g :vimgrep // **/*.<s-left><s-left><right>
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" Encoding

set fileformat=unix
set fileformats=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

" Text formatting

syntax enable
set autoindent smartindent
set showmatch
set expandtab smarttab tabstop=2 shiftwidth=2 softtabstop=2
set linebreak

filetype plugin on
filetype indent on

" Command line
cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" Diff options
set diffopt=filler,vertical
noremap <leader>du :diffupdate<enter>
nnoremap <leader>di :diffsplit<space>

" Editing
inoremap $@ ()<left>
inoremap $2 []<left>
inoremap $# {}<left>
inoremap $3 <><left>
inoremap $4 {}<left><enter><esc>O
inoremap $e ''<left>
inoremap $E ""<left>
inoremap $R <backspace><delete>

inoreabbrev rt return

" Move around while in editing mode
" But c-h cannot be reboud.
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-c> <esc>
inoremap <s-enter> <end>;<enter>
inoremap <c-enter> <end><enter>

noremap <space> ^
noremap 0 ^
noremap <s-space> $

nnoremap <enter> A<enter><esc>
nnoremap <s-enter> A;<esc>
nnoremap <c-enter> i<enter><esc>
nnoremap <backspace> :noh<enter>
nnoremap <leader>ht :set filetype=html<enter>
nnoremap <leader>js :set filetype=javascript<enter>
nnoremap <leader>== gg=G``

" Since 7.3:
if version >= 703
  set undofile
  set undodir=~/.tmp
  set undolevels=1000

  set relativenumber
else
  set number
endif

" for MiniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 
