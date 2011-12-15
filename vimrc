filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-surround'
Bundle '5long/ryve'
Bundle 'wincent/Command-T'
Bundle 'mileszs/ack.vim'
Bundle 'mako.vim'
Bundle 'mako.vim--Torborg'
Bundle 'juvenn/mustache.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'Syntastic'
runtime macros/matchit.vim

let g:mapleader=","
let g:maplocalleader="\\"

let g:lucius_style = 'blue'
colorscheme lucius

set nomodeline

set relativenumber
set lazyredraw
set ttyfast
set mouse=n

set switchbuf=usetab
nnoremap <c-n> :bnext<enter>
nnoremap <c-p> :bprevious<enter>

set scrolloff=6
set cursorcolumn cursorline
set showmatch
set list
set listchars=tab:▸\ ,trail:·
set linebreak
set textwidth=75
set formatoptions+=B1

syntax enable
set autoindent
set shiftround
set expandtab smarttab
for s:key in ['tabstop', 'shiftwidth', 'softtabstop']
  exec 'set ' . s:key . '=2'
endfor
unlet s:key
filetype plugin indent on

autocmd FileType * setl foldmethod=manual
autocmd BufRead,BufNewFile *.md setfiletype=markdown
autocmd FileType mako setl ts=2 sw=2 sts=2
autocmd FileType css setl isk+=-

" Set the damn file type
nnoremap <LocalLeader><LocalLeader> :setfiletype<space>
nnoremap <LocalLeader>mk :setfiletype<space>html.mako<cr>
nnoremap <LocalLeader>js :setfiletype<space>javascript<cr>
let g:javascript_ignore_javaScriptdoc = 1

cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

set history=300
set cmdheight=2
set showcmd
set wildmenu
set wildmode=longest:full,full
set laststatus=0
set rulerformat=%100(%f%m%R%H%W\ \ in\ %{CurDir()}%)
set shortmess+=aI

function! CurDir()
  let curdir = substitute(getcwd(),$HOME,"~","g")
  return curdir
endfunction

set ignorecase smartcase
set incsearch
set hlsearch
nnoremap <backspace> :nohlsearch<enter>
noremap / /\v
noremap ? ?\v

for s:key in ['#', '*', 'n', 'N']
  exec printf('nnoremap %s %szz', s:key, s:key)
endfor
unlet s:key

set autoread
set noswapfile
set nobackup
set nowritebackup
set hidden
set undofile
set undodir=~/.tmp
set undolevels=1000
autocmd BufReadPost * silent! normal g`"
autocmd! FocusLost * silent! wall
set autowrite

nnoremap <leader>w :update<CR>
nnoremap <leader>dd :bdelete<CR>
nnoremap <leader>da :1,300bdelete<CR>

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lc :lcd %:p:h<CR>
nnoremap <leader>g :Ack -Qw '' --all<s-left><left><left>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>

set fileformats=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

set diffopt=filler,vertical
noremap <leader>du :diffupdate<enter>
nnoremap <leader>di :diffthis<enter>
nnoremap <leader>do :diffoff!<enter>

set backspace=eol,start,indent
set noesckeys

xmap s <Plug>VSurround
imap <c-s> <Plug>ISurround
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

" Let's give it a shot
nnoremap <space> a<space><esc>r
nnoremap <cr> a<space><esc>r<cr>

" Leave <c-h> for backspace
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-e> <c-o>A
inoremap <c-a> <c-o>I

nmap <F1> <nop>
nmap K <nop>
inoremap <c-space> <nop>
nnoremap Y y$
noremap H ^
noremap L $
map <tab> %

nnoremap <leader>db <c-w>o<c-w>v
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

let g:CommandTMaxHeight = 10
let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
let g:CommandTCursorLeftMap = '<Left>'
nnoremap <leader>ft :CommandTFlush<enter>
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo,*.ptlc
set wildignore+=node_modules
set suffixes+=.log

let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_warnings=1

" Since I'm a plugin author now
nnoremap <leader>so :source %<CR>

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
