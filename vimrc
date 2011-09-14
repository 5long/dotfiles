let g:mapleader=","

"" Interface
if !has("gui_running")
  set t_Co=256
endif
colorscheme lucius

if has('gui_gtk2')
  set guifont=Terminus\ 12
  set guifontwide=WenQuanYi\ Zen\ Hei\ Mono
else
  set guifont=Consolas:h12
endif

" Tab and decorations.
set switchbuf=usetab
set relativenumber
if has("gui_running")
  set guioptions=aeicM

  nnoremap <leader><tab>n :tabnew<enter>
  nnoremap <leader><tab>c :tabclose<enter>
  nnoremap <c-tab> :tabnext<enter>
  nnoremap <c-s-tab> :tabprevious<enter>
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
set virtualedit=block,onemore

syntax enable
set autoindent smartindent
set expandtab smarttab tabstop=2 shiftwidth=2 softtabstop=2
filetype plugin on
filetype indent on

" Fix filetype
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Command line and status line.
cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

set history=300
set cmdheight=2
set showcmd
set ruler
set wildmenu
set wildmode=longest:full
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %{CurDir()}\ \ \ Line:\ %l/%L:%c

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
set noswapfile
set nobackup
set hidden
set undofile
set undodir=~/.tmp
set undolevels=1000
autocmd! BufWritePost .vimrc source ~/.vimrc
autocmd BufReadPost * normal `"
autocmd! FocusLost * wall
set autowrite

nnoremap <leader>w :update<CR>
nnoremap <leader>dd :bdelete<CR>
nnoremap <leader>da :1,300bdelete<CR>

" Utilities
nnoremap <leader>au :autocmd  <buffer><space><s-left><left>
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lc :lcd %:p:h<CR>
nnoremap <leader>g :Ack  --<s-left><left>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>== gg=G``

" Encoding
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

nnoremap <enter> A;<enter>

inoremap $<space> <space><space><left>
inoremap $@ ()<left>
inoremap $2 []<left>
inoremap $# {}<left>
inoremap $3 <><left>
inoremap $4 {}<left><enter><esc>O
inoremap $$ $
inoremap $e ''<left>
inoremap $E ""<left>
inoremap $R <backspace><delete>

inoreabbrev rt return

" Move around while in editing mode
" Leave <c-h> for backspace
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-e> <c-o>E

" Movement
noremap <space> ^
noremap <s-space> $
map <tab> %

" Since minibufexpl is removed
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Enable matchit
runtime macros/matchit.vim

" for Command-T
nnoremap <leader>ft :CommandTFlush<enter>
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo
set wildignore+=node_modules
set suffixes+=.log

nmap <F1> <nop>
