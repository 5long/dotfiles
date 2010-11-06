let g:mapleader=","

"" Interface
if !has("gui_running")
  set t_Co=256
endif
colorscheme lucius

if has('gui_gtk2')
  set guifont=DejaVu\ Sans\ Mono\ 13
  set guifontwide=WenQuanYi\ Zen\ Hei\ Mono\ 13
else
  set guifont=Consolas:h12
endif

" Tab and decorations.
set switchbuf=usetab
set relativenumber
if has("gui_running")
  set showtabline=2
  set guioptions=aeicM

  nnoremap <leader><tab>n :tabnew<enter>
  nnoremap <leader><tab>c :tabclose<enter>
  nnoremap <c-tab> :tabnext<enter>
  nnoremap <c-s-tab> :tabprevious<enter>
else
  set showtabline=1
endif

" Buffer
nnoremap <c-n> :bnext<enter>
nnoremap <c-p> :bprevious<enter>

" Textarea
set scrolloff=6
set cursorcolumn cursorline
set showmatch
set list
set listchars=tab:▸\ ,trail:·
set linebreak
set textwidth=75

syntax enable
set autoindent smartindent
set expandtab smarttab tabstop=2 shiftwidth=2 softtabstop=2
filetype plugin on
filetype indent on

" Command line and status line.
cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

set history=300
set cmdheight=2
set showcmd
set ruler
set wildmenu
set wildmode=longest,full
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c:

function! CurDir()
  let curdir = substitute(getcwd(),'/home/whyme/',"~/","g")
  return curdir
endfunction

" Searching
set ignorecase smartcase
set incsearch
set hlsearch
nnoremap <backspace> :nohlsearch<enter>
noremap / /\v

" Internal

" Filehandle

set autoread
set nobackup
set hidden
set directory-=.
set directory+=~/.tmp
set undofile
set undodir=~/.tmp
set undolevels=1000
autocmd! BufWritePost .vimrc source ~/.vimrc
autocmd BufReadPost * normal `"
autocmd! FocusLost * wall

nnoremap <leader>w :update<CR>
nnoremap <leader>dd :bdelete<CR>

" Utilities
nnoremap <leader>au :autocmd  <buffer><space><s-left><left>
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>g :vimgrep // **/*.<s-left><s-left><right>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>== gg=G``

" Encoding
set fileformat=unix
set fileformats=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

" Diff options
set diffopt=filler,vertical
noremap <leader>du :diffupdate<enter>
nnoremap <leader>di :diffthis<enter>
nnoremap <leader>do :diffoff!<enter>

" Editing
set backspace=eol,start,indent

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
" Leave <c-h> for backspace
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
noremap <space> ^
noremap <s-space> $

" for MiniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplModSelTarget = 1
