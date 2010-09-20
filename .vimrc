" Hotkeys first
let mapleader=","
let g:mapleader=","

" Interface
colorscheme lucius

if has('gui_gtk2')
  set guifont=DejaVu\ Sans\ Mono\ 13
  " set guifont=Inconsolata\ 13
  set guifontwide=WenQuanYi\ Zen\ Hei\ Mono\ 13
else
  set guifont=Consolas:h12
endif

" Windows
" move among windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set switchbuf=usetab
set stal=2

set nocompatible
set history=300
set showcmd
set ruler
set cmdheight=2
set number
set scrolloff=6

set ignorecase
set incsearch
set hlsearch
set magic
set mat=5
set backspace=eol,start,indent

" Status Line
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c:

function! CurDir()
  let curdir = substitute(getcwd(),'/home/whyme/',"~/","g")
  return curdir
endfunction

if has("gui_running")
  set guioptions-=T
endif

" Keep silent
set noerrorbells
set novisualbell
set t_vb=

" Filehandle
" automatically reload .vimrc file
set wildmenu
set autoread
autocmd! bufwritepost .vimrc source ~/.vimrc

nnoremap <leader>w :up<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>s :e ~/.vim/snippets/
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" Encoding

set fileformat=unix
set fileformats=unix,dos,mac
set encoding=utf-8
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

" Text formatting

syntax enable
set autoindent smartindent
set showmatch
set expandtab smarttab tabstop=2 shiftwidth=2 softtabstop=2
set wrap linebreak

filetype plugin on
filetype indent on

" Command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" Editing
inoremap $@ ()<left>
inoremap $2 []<left>
inoremap $# {}<left>
inoremap $3 <><left>
inoremap $4 {}<left><enter><esc>O
inoremap $e ''<left>
inoremap $E ""<left>
inoremap $R <backspace><delete>

" Move around while in editing mode
" But c-h cannot be reboud.
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <s-enter> <end>;<enter>
inoremap <c-enter> <end><enter>

noremap <space> ^
noremap 0 ^
noremap <s-space> $

nnoremap <enter> A<enter><esc>
nnoremap <s-enter> A;<esc>
nnoremap <c-enter> i<enter><esc>
nnoremap <backspace> :noh<enter>
" nnoremap <leader>nt :NERDTreeToggle<enter>
nnoremap <leader>ht :set filetype=html<enter>
nnoremap <leader>js :set filetype=javascript<enter>

" Since 7.3:
"
" Persistent undo
set undodir="~/.tmp"
set undolevels=1000

" for css?
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" for MiniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

