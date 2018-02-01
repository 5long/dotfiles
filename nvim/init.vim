call plug#begin('~/.local/share/nvim/plugged')

" Colorz!
Plug 'NLKNguyen/papercolor-theme'

" Editing / Operator / Everyday command
Plug '5long/ryve'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'cohama/lexima.vim'
Plug 'justinmk/vim-sneak'

if ! executable('fzf')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'

" Make Vim Better
Plug '5long/vim-imtoggle'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-dirvish'

" Make-vim-more-like-IDE
Plug '5long/ragain'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neomake/neomake'
if has('nvim')
  Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'}
  Plug 'roxma/nvim-completion-manager'
endif

" Filetype-specific
Plug 'sheerun/vim-polyglot'
Plug '5long/pytest-vim-compiler'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'Galooshi/vim-import-js'

" Not used that much, might be deleted / re-learnt
Plug 'tpope/vim-projectionist'

Plug '/usr/share/vim/vimfiles'

call plug#end()

let g:plug_threads = 5

runtime macros/matchit.vim

set exrc
set secure

let g:mapleader=','
let g:maplocalleader=' '

let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [], [ 'readonly', 'cwd', 'filename', 'modified' ] ],
  \   'right': [ [ 'neomake' ],
  \              [ 'lineinfo' ],
  \              [ 'filetype' ] ],
  \ },
  \ 'inactive': {
  \   'right': [ [],
  \              [ 'lineinfo' ],
  \              [] ],
  \ },
  \ 'tabline': {
  \   'right': [ ], },
  \ 'component_function': {
  \   'cwd': 'CurDir',
  \ },
  \ 'component_expand': {
  \   'neomake': 'LightLineNeomake',
  \ },
  \ 'component_type': {
  \   'neomake': 'error',
  \ },
  \ }

hi link SneakPluginTarget Search
hi link SneakStreakTarget Search

if has('nvim')
  set termguicolors
endif
colorscheme PaperColor
if $TERM =~ '^linux'
  set background=dark
endif

set relativenumber
set lazyredraw

set switchbuf=usetab
nnoremap <leader><leader> <c-^>

set scrolloff=6
set cursorcolumn cursorline
set showmatch
set list
" Remember rendar at #vim.
set listchars=tab:›\ ,trail:·
" let &listchars = "tab:\u203a ,trail:\xb7"
set textwidth=75
set formatoptions+=B1nlm
set formatoptions-=tc
set cpoptions+=J

set shiftround
set expandtab
for s:key in ['tabstop', 'shiftwidth', 'softtabstop']
  exec 'set ' . s:key . '=2'
endfor
unlet s:key

augroup vimrc
  autocmd!
augroup end

" Set the damn file type
nnoremap <LocalLeader><LocalLeader> :setfiletype<space>

" Indentation
nnoremap <LocalLeader>i2 :setl ts=2 sw=2 sts=2<CR>
nnoremap <LocalLeader>i4 :setl ts=4 sw=4 sts=4<CR>
nnoremap <LocalLeader>et :setl et!<CR>

function! CmdlineKillTillEnd()
  return strpart(getcmdline(), 0, getcmdpos())
endfunction

cnoremap <c-a> <Home>
cnoremap <c-n> <Down>
cnoremap <c-p> <Up>
cnoremap <a-b> <c-left>
cnoremap <c-k> <c-\>eCmdlineKillTillEnd()<cr>
cnoremap %% <c-r>=expand('%:h').'/'<CR>
cnoremap <c-v>b <c-r>=expand('%:r')<CR>

set cmdheight=2
set showcmd
set wildmode=longest:full,full
set wildignorecase
set completeopt=menu,preview,longest
set shortmess+=aI
set noshowmode

let s:home = resolve($HOME)
function! CurDir()
  return pathshorten(substitute(getcwd(), '^' . s:home, '~', ''))
endfunction

set ignorecase smartcase
if has('nvim')
  set inccommand=nosplit
endif
noremap / /\v
noremap ? ?\v
nnoremap <backspace> :nohlsearch<cr>:diffupdate<cr><c-l>

noremap <leader>sw :s/<c-r><c-w>//g<left><left>
nnoremap gs WhvgElc<space><esc>
nnoremap gS gElvWlc<space><esc>

for s:key in ['#', '*', 'n', 'N']
  exec printf('nnoremap %s %szz', s:key, s:key)
endfor
unlet s:key

set noswapfile
set nobackup
set nowritebackup
set hidden
set undofile

autocmd vimrc FocusLost * silent! wall
set autowrite

nnoremap <leader>w :update<CR>
nnoremap QQ :qa!<CR>

nnoremap <leader>da :1,$bd!<CR><c-w><c-v>

if has('nvim')
  nnoremap <leader>tt :new\|terminal<space>
  autocmd vimrc TermOpen term://* startinsert
  autocmd vimrc BufEnter term://* startinsert
  autocmd vimrc BufLeave term://* stopinsert
endif

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap gF :call <SID>OpenCfile()<CR>
fun! s:OpenCfile()
  let cfile = s:ResolveCfile()
  exec ":e " cfile
endf

fun! s:ResolveCfile()
  let dir = expand('%:h') . '/'
  let ext = expand('%:e')
  let cfile = expand('<cfile>')
  let fullPath = dir . cfile . "." . ext

  py3 from os.path import normpath
  return py3eval(printf("normpath('%s')", fullPath))
endf

set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m
autocmd vimrc QuickFixCmdPost grep rightbelow cwindow 7
command! -nargs=+ -complete=file -bar Grep silent grep! -w <args>|redraw!
nnoremap <leader>gg :Grep<space>
nnoremap <leader>gw :Grep<space><c-r><c-w>

nmap <leader>r <Plug>RagainRun
nmap <leader>R <Plug>RagainResetAndRun
nmap <leader>mr :RagainSetAndRun  <c-r>=expand('%')<CR><s-left><left>
nnoremap <leader>mm :RagainSetAndRun make

nnoremap <leader>tn :<c-u>tabe<CR>
nnoremap <leader>ts :<c-u>tab split<CR>
nnoremap <leader>td :<c-u>tcd %:p:h<CR>
nnoremap <leader>tc :<c-u>tabclose<CR>

for s:tabi in range(1,9)
  exec printf("nnoremap <m-%d> %dgt", s:tabi, s:tabi)
endfor
nnoremap <m-0> :$tabnext<CR>

set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

set diffopt=filler,vertical,iwhite
noremap <leader>du :diffupdate<CR>

let $FZF_DEFAULT_OPTS = '--color=light'
nnoremap <leader>f :Files<CR>
nnoremap <leader>df :args `git status --porcelain=v1 <bslash><bar> awk '{print $2}'`<cr>
nnoremap <leader>bf :Buffers<CR>
nnoremap <leader>/ :Lines<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --vimgrep --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


nmap <c-s> <Plug>Ysurround
xmap s <Plug>VSurround
imap <c-s> <Plug>ISurround

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

inoreabbrev rt return

set pastetoggle=<f5>
set mouse=a

" Leave <c-h> for backspace
inoremap <c-j> <c-g>U<down>
inoremap <c-k> <c-g>U<up>
inoremap <c-l> <c-g>U<right>
inoremap <c-e> <c-g>U<c-o>A
inoremap <c-a> <c-g>U<c-o>I

let g:sneak#use_ic_scs = 1
nmap <space> <Plug>Sneak_s
nmap <m-space> <Plug>Sneak_S

nmap <F1> <nop>
nmap Q <nop>
inoremap <c-space> <nop>
inoremap <c-c> <esc>
nnoremap Y y$
nnoremap yu "+yiW
noremap H ^
noremap L $
map <tab> %
noremap <c-p> <c-i>

nnoremap <leader>ov <c-w>o<c-w>v
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" neovim supports m-* mappings now
nnoremap <m-h> <c-w>h
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo,*.ptlc
set wildignore+=*.class,*.dex,*.apk,*.jar,*.idx,*.bin,*/build/*
set wildignore+=*.tgz,*.tar.gz,*.tar.xz,*.tar.bz2,*.zip
set wildignore+=node_modules
set wildignore+=_site
set wildignore+=*.o,*.so
set wildignore+=pkg,*.gem
set suffixes+=.log

let g:neomake_place_signs = 0
let g:neomake_python_enabled_makers = ['pyflakes']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = 'npx'
let g:neomake_javascript_eslint_args = ['eslint', '-f', 'compact', '-c', s:home . '/.eslintrc.yaml']
autocmd vimrc BufWritePost * Neomake
autocmd vimrc User NeomakeCountsChanged call OnNeomakeCountsChanged()

fun! OnNeomakeCountsChanged()
  call lightline#update()
endfun

fun! LightLineNeomake()
  return neomake#statusline#LoclistStatus()
endf

let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''

autocmd vimrc VimEnter * if empty(expand('%')) | setl buftype=nofile

let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

if has('nvim')
  let g:LanguageClient_diagnosticsEnable = 0
  let g:LanguageClient_diagnosticsList = 'location'
  let g:LanguageClient_serverCommands = {
        \ 'javascript': ['javascript-typescript-stdio'],
        \ 'javascript.jsx': ['javascript-typescript-stdio'],
        \ }
  let g:LanguageClient_autoStart = 1
  augroup vimrc
    autocmd FileType javascript*
          \ nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType javascript*
          \ nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  augroup END
endif

" Since I'm a plugin author now
nnoremap <leader>so :source %<CR>
let g:nvimrc = expand('<sfile>')
nnoremap <leader>ev :e <c-r>=g:nvimrc<CR><CR>

command! CN IMEnable

let s:localrc = g:nvimrc . '.local'
if filereadable(s:localrc)
  exec 'source ' . fnameescape(s:localrc)
endif
