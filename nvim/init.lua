require('plugins')

vim.g.mapleader = ','

local opt, keymap, cmd = vim.opt, vim.keymap, vim.cmd

local function noremap(mode, lhs, rhs, opts)
  keymap.set(mode, lhs, rhs, vim.tbl_extend('force', {noremap = true}, opts or {}))
end

local function partial(f, arg)
  return function(...)
    return fn(arg, ...)
  end
end

opt.mouse='a'
opt.exrc = true
opt.relativenumber = true
opt.lazyredraw = true

-- neovim-qt sets TERM=linux
if vim.fn.has('gui_running') or os.getenv('TERM') ~= "linux" then
  opt.termguicolors = true
  opt.background = 'light'
  vim.env.FZF_DEFAULT_OPTS = '--color=light'
else
  opt.background = 'dark'
end

vim.g.edge_transparent_background = true
vim.g.edge_better_performance = true
vim.g.edge_disable_italic_comment = true
cmd.colorscheme("edge")

opt.switchbuf = 'useopen,usetab'
noremap('n', '<leader><leader>', '<c-^>')

opt.scrolloff = 6

for _,v in ipairs{'cursorcolumn', 'cursorline', 'showmatch', 'list'} do
  opt[v] = true
end

opt.listchars = { tab = '› ', trail = '·'}
opt.textwidth = 68
opt.formatoptions:append('B1nlm') -- what a mouthful
opt.formatoptions:remove('tc') -- Only manually format w/ gq
opt.cpoptions:append('J')

opt.shiftround = true
opt.expandtab = true

local function set_indent(n, target)
  for _,v in ipairs{'tabstop', 'shiftwidth', 'softtabstop'} do
    target[v] = n
  end
end
set_indent(2, opt)

local augroup = vim.api.nvim_create_augroup('vimrc', { clear = true })
local function autocmd(events, opts)
  vim.api.nvim_create_autocmd(
    events,
    vim.tbl_extend('force', {group = augroup}, opts)
  )
end

noremap('n', '<leader>i2', function()
  set_indent(2, vim.opt_local)
end)

noremap('n', '<leader>i4', function()
  set_indent(4, vim.opt_local)
end)

noremap('c', '<c-a>', '<Home>')
noremap('c', '<c-n>', '<Down>')
noremap('c', '<c-p>', '<Up>')
noremap('c', '<a-b>', '<c-left>')
noremap('c', '%%', "<c-r>=expand('%:h').'/'<CR>")
noremap('c', '<c-v>b', "<c-r>=expand('%:r')<CR>")
noremap('c', '<c-k>', "<C-\\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>")

opt.wildmode = 'longest:full,full'
opt.wildignorecase = true
opt.completeopt = 'menu,preview,longest'
opt.shortmess:append('aI')
opt.showmode = false

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

noremap('', '/', '/\\v')
noremap('', '?', '?\\v')
noremap('n', '<backspace>', function ()
  cmd.nohlsearch()
  cmd.diffupdate()
  cmd('normal! <C-L>')
end)

noremap('n', '<leader>sw', ':s/<c-r><c-w>//g<left><left>')

for _,k in ipairs{'#', '*', 'n', 'N'} do
  noremap('n', k, k .. 'zz')
end

opt.swapfile = false
opt.undofile = true

autocmd('FocusLost', {
  command = "silent! wall"
})
opt.autowrite = true

noremap('n', '<leader>w', vim.cmd.update)
noremap('n', 'QQ', vim.cmd.cquit)
noremap('n', '<leader>da', ':1,$bd!<CR><c-w><c-v>')
noremap('n', '<leader>cd', ':cd %:p:h<CR>')

noremap('n', 'yaf', 'gg"+yG``')
noremap('n', '<leader>yf', function() 
  vim.fn.setreg('+', vim.fn.expand('%')) 
end)
noremap('n', '<leader>yd', function() 
  vim.fn.setreg('+', vim.fn.expand('%:h')) 
end)

opt.grepprg = 'rg --vimgrep --no-require-git'
opt.grepformat:prepend('%f:%l:%c:%m')
autocmd('QuickFixCmdPost', {
  pattern = 'grep',
  command = 'rightbelow cwindow 7',
})
cmd("command! -nargs=+ -complete=file -bar Grep silent grep! -w <args>|redraw!")
noremap('n', '<leader>gg', ':Grep<space>')
noremap('n', '<leader>gw', ':Grep<space><c-r><c-w>')

keymap.set('n', '<leader>x', '<Plug>RagainRun')
keymap.set('n', '<leader>X', '<Plug>RagainResetAndRun')
keymap.set('n', '<leader>mx', ":RagainSetAndRun  <c-r>=expand('%')<CR><s-left><left>")

noremap('n', '<leader>tn', cmd.tabedit)
noremap('n', '<leader>ts', partial(cmd.tab, 'split'))
noremap('n', '<leader>td', partial(cmd.tcd, '%:p:h'))
noremap('n', '<leader>tc', cmd.tabclose)

for i=1,9 do
  noremap('n', '<m-'..i..'>', i..'gt')
end
noremap('n', '<m-0>', ':$tabnext<CR>')

opt.fileformats = 'unix,dos,mac'
opt.fileencodings = 'ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1'
opt.diffopt = 'internal,filler,vertical,iwhite,indent-heuristic,algorithm:histogram'
noremap('n', '<leader>du', cmd.diffupdate)

noremap('n', '<leader>f', cmd.Files)
noremap('n', '<leader>df', ":args `git status --porcelain=v1 <bslash><bar> awk '{print $2}'`<cr>")
noremap('n', '<leader>bf', cmd.Buffers)
noremap('n', '<leader>/', cmd.Lines)

keymap.set('x', 's', '<Plug>(nvim-surround-visual)')

noremap('n', 'j', "v:count ? 'j' : 'gj'", {expr = true})
noremap('n', 'k', "v:count ? 'k' : 'gk'", {expr = true})

cmd.inoreabbrev('rt', 'return')

noremap('i', '<c-j>', '<c-g>U<down>')
noremap('i', '<c-k>', '<c-g>U<up>')
noremap('i', '<c-l>', '<c-g>U<right>')
noremap('i', '<c-e>', '<c-g>U<c-o>A')
noremap('i', '<c-a>', '<c-g>U<c-o>I')

keymap.set('n', '<F1>', '<nop>')
keymap.set('n', 'Q', '<nop>')
noremap('n', 'yu', '"+yiW')
noremap('', 'H', '^')
noremap('', 'L', '$')
keymap.set('n', '<tab>', '%')
noremap('', '<c-9>', '<c-i>')

noremap('n', '<c-h>', '<c-w>h')
noremap('n', '<c-j>', '<c-w>j')
noremap('n', '<c-k>', '<c-w>k')
noremap('n', '<c-l>', '<c-w>l')

local wig = opt.wildignore
wig:append('*/.git/*,*/.hg/*')
wig:append('*.pyc,*.pyo,*.ptlc')
wig:append('*.class,*.dex,*.apk,*.jar,*.idx,*.bin,*/build/*')
wig:append('*.tgz,*.tar.gz,*.tar.xz,*.tar.bz2,*.zip')
wig:append('node_modules')
wig:append('_site')
wig:append('*.o,*.so')
wig:append('pkg,*.gem')
wig:append('.log')

autocmd('VimEnter', {
  command = "if empty(expand('%')) | setl buftype=nofile"
})

local function silent_map(mode, lhs, rhs, opt)
	vim.keymap.set(mode, lhs, rhs,
    vim.tbl_extend('error', { silent = true }, opt or {})
  )
end

-- This is stupid
cmd([[ imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ]])

silent_map('s', '<Tab>', function()
  require('luasnip').jump(1)
end)
silent_map({'i', 's'}, '<S-Tab>', function()
  require('luasnip').jump(-1)
end)
