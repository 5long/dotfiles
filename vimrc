if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand("~/.vim/bundle/"))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle '5long/ryve'
NeoBundle '5long/ragain'
NeoBundle 'tpope/vim-surround'
NeoBundle 'wincent/Command-T', {'build': {'unix': 'rake make'}}
NeoBundle 'SirVer/ultisnips'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'bufkill.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'reinh/vim-makegreen'

NeoBundle 'tpope/vim-endwise'
NeoBundle 'mattn/zencoding-vim'
NeoBundle '5long/pytest-vim-compiler'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'mako.vim'
NeoBundle 'mako.vim--Torborg'
NeoBundle 'juvenn/mustache.vim'
NeoBundle 'vim-ruby/vim-ruby'
runtime macros/matchit.vim

set exrc
set secure

let g:mapleader=','
let g:maplocalleader='\\'

let g:lucius_style = 'blue'
if !has('gui_running')
  set t_Co=256
endif
colorscheme lucius

nnoremap <leader>hc :call ToggleCommentHighlight()<CR>
let s:comment_highlighting = 0
function! ToggleCommentHighlight()
  if s:comment_highlighting
    let s:comment_highlighting = 0
    colorscheme lucius
    return
  endif

  let s:comment_highlighting = 1
  hi Comment guifg=#bcbcbc gui=none
  hi Comment ctermfg=250 cterm=none
endfunction

set nomodeline

set relativenumber
set lazyredraw
set ttyfast
set mouse=n

set switchbuf=usetab
nnoremap <leader><leader> <c-^>

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

" Set the damn file type
nnoremap <LocalLeader><LocalLeader> :setfiletype<space>
nnoremap <LocalLeader>mk :setfiletype<space>html.mako<CR>
nnoremap <LocalLeader>er :setfiletype<space>html.eruby<CR>
nnoremap <LocalLeader>js :setfiletype<space>javascript<CR>
nnoremap <LocalLeader>lq :setfiletype<space>html.liquid<CR>
let g:javascript_ignore_javaScriptdoc = 1
let g:vim_markdown_folding_disabled = 1

" Indentation
nnoremap <LocalLeader>i2 :setl ts=2 sw=2 sts=2<CR>
nnoremap <LocalLeader>i4 :setl ts=4 sw=4 sts=4<CR>
nnoremap <LocalLeader>et :setl et!<CR>

cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap %% <c-r>=expand('%:h').'/'<CR>

set history=300
set cmdheight=2
set showcmd
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set statusline=\ %f%m%R%H%W\ in\ %{CurDir()}\ \ Cur:%l/%L:%c
set shortmess+=aI

function! CurDir()
  let curdir = substitute(getcwd(),$HOME,'~','g')
  return curdir
endfunction

set ignorecase smartcase
set incsearch
set hlsearch
nnoremap <backspace> :nohlsearch<CR>
noremap / /\v
noremap ? ?\v

for s:key in ['#', '*', 'n', 'N']
  exec printf('nnoremap %s %szz', s:key, s:key)
endfor
unlet s:key

set noswapfile
set nobackup
set nowritebackup
set hidden
set undofile
set undodir=~/.tmp
set undolevels=1000

autocmd! FocusLost * silent! wall
set autoread
set autowrite

nnoremap <leader>w :update<CR>
nnoremap QQ :qa!<CR>
nnoremap <leader>md :silent! call mkdir(expand('%:p:h'), 'p')<CR>

let g:BufKillActionWhenBufferDisplayedInAnotherWindow = 'kill'
let g:BufKillVerbose = 0
nnoremap <leader>dd :BD<CR>
nnoremap <leader>da :silent bufdo BD<CR>

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lc :lcd %:p:h<CR>
nnoremap <leader>gg :Ack -Q ''<left>
nnoremap <leader>gw :Ack -Qw ''<left><c-r><c-w>
nmap <leader>e <Plug>RagainRun
nmap <leader>E <Plug>RagainResetAndRun
nmap <leader>me :RagainSetAndRun  <c-r>=expand('%')<CR><s-left><left>

set fileformats=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

set diffopt=filler,vertical
noremap <leader>du :diffupdate<CR>

set backspace=eol,start,indent
set noesckeys

nmap <c-s> <Plug>Ysurround
xmap s <Plug>VSurround
imap <c-s> <Plug>ISurround
inoremap $<space> <space><space><left>
inoremap $@ ()<left>
inoremap $2 []<left>
inoremap $# {}<left>
inoremap $3 <><left>
inoremap $4 {}<left><CR><esc>O
inoremap $$ $
inoremap $e ''<left>
inoremap $E ""<left>
inoremap $R <backspace><delete>

inoreabbrev rt return

noremap n' :<C-U>call <SID>TextObjNext("'")<CR>
nunmap n'
noremap n" :<C-U>call <SID>TextObjNext('"')<CR>
nunmap n"

function! s:TextObjNext(type)
  let l:cmd = printf('normal! /%svi%s', a:type, a:type)
  exec cmd
endfunction

" Let's give it a shot
nnoremap <space> a<space><esc>r

function! EnterHit()
  if stridx(&buftype, 'quickfix') != -1
    normal! 
  else
    normal! a r
  endif
endfunction

nnoremap <CR> :call EnterHit()<CR>

set pastetoggle=<f5>

" Leave <c-h> for backspace
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-e> <c-o>A
inoremap <c-a> <c-o>I

nnoremap <c-n> :tabe \| lcd ~/

nmap <F1> <nop>
nmap K <nop>
nmap Q <nop>
inoremap <c-space> <nop>
nnoremap Y y$
noremap H ^
noremap L $
map <tab> %
noremap <c-p> <c-i>

nnoremap <leader>ov <c-w>o<c-w>v
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

let g:ackprg='ag -S --nocolor --nogroup --column'

nnoremap <leader>r :MakeGreen %<CR>

let g:CommandTMaxHeight = 10
let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
let g:CommandTCursorLeftMap = '<Left>'
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
nnoremap <leader>f :CommandT<CR>
nnoremap <leader>pf :CommandTFlush<CR>
nnoremap <leader>bf :CommandTBuffer<CR>
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo,*.ptlc
set wildignore+=*.class,*.dex,*.apk,*.jar
set wildignore+=*.tgz,*.tar.gz,*.tar.xz,*.tar.bz2,*.zip
set wildignore+=node_modules
set wildignore+=_site
set wildignore+=*.o,*.so
set wildignore+=pkg,*.gem
set suffixes+=.log

let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['puppet', 'scala', 'html'],}

let g:user_zen_leader_key='<Plug><Plug>'
let g:user_zen_expandabbr_key='<c-u>'
" Shut zencoding up
nnoremap <c-u> <c-u>

let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''

autocmd VimEnter * if empty(expand('%')) | setl buftype=nofile

let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsDontReverseSearchPath='1'

" Since I'm a plugin author now
nnoremap <leader>so :source %<CR>

if has('gui_gtk2')
  set guifont=Terminus\ 12
  set guifontwide=WenQuanYi\ Zen\ Hei\ Mono
endif

set guioptions=aicM

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
