require('plugins')

vim.g.mapleader = ','

local opt, keymap, cmd = vim.opt, vim.keymap, vim.cmd

remap = {remap = true}

local function partial(f, arg)
  return function(...)
    return f(arg, ...)
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
keymap.set('n', '<leader><leader>', '<c-^>')

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

keymap.set('n', '<leader>i2', function()
  set_indent(2, vim.opt_local)
end)

keymap.set('n', '<leader>i4', function()
  set_indent(4, vim.opt_local)
end)

keymap.set('c', '<c-a>', '<Home>')
keymap.set('c', '<c-n>', '<Down>')
keymap.set('c', '<c-p>', '<Up>')
keymap.set('c', '<a-b>', '<c-left>')
keymap.set('c', '%%', "<c-r>=expand('%:h').'/'<CR>")
keymap.set('c', '<c-v>b', "<c-r>=expand('%:r')<CR>")
keymap.set('c', '<c-k>', "<C-\\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>")

opt.wildmode = 'longest:full,full'
opt.wildignorecase = true
opt.completeopt = 'menu,preview,longest'
opt.shortmess:append('aI')
opt.showmode = false

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

keymap.set('', '/', '/\\v')
keymap.set('', '?', '?\\v')
keymap.set('n', '<backspace>', function ()
  cmd.nohlsearch()
  cmd.diffupdate()
  cmd('normal! <C-L>')
end)

keymap.set('n', '<leader>sw', ':s/<c-r><c-w>//g<left><left>')

for _,k in ipairs{'#', '*', 'n', 'N'} do
  keymap.set('n', k, k .. 'zz')
end

opt.swapfile = false
opt.undofile = true

autocmd('FocusLost', {
  command = "silent! wall"
})
opt.autowrite = true

keymap.set('n', '<leader>w', vim.cmd.update)
keymap.set('n', 'QQ', vim.cmd.cquit)
keymap.set('n', '<leader>da', ':1,$bd!<CR><c-w><c-v>')
keymap.set('n', '<leader>cd', ':cd %:p:h<CR>')

keymap.set('n', 'yaf', 'gg"+yG``')
keymap.set('n', '<leader>yf', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end)
keymap.set('n', '<leader>yd', function()
  vim.fn.setreg('+', vim.fn.expand('%:h'))
end)

opt.grepprg = 'rg --vimgrep --no-require-git'
opt.grepformat:prepend('%f:%l:%c:%m')
autocmd('QuickFixCmdPost', {
  pattern = 'grep',
  command = 'rightbelow cwindow 7',
})
cmd("command! -nargs=+ -complete=file -bar Grep silent grep! -w <args>|redraw!")
keymap.set('n', '<leader>gg', ':Grep<space>')
keymap.set('n', '<leader>gw', ':Grep<space><c-r><c-w>')

keymap.set('n', '<leader>x', '<Plug>RagainRun', remap)
keymap.set('n', '<leader>X', '<Plug>RagainResetAndRun', remap)
keymap.set('n', '<leader>mx', ":RagainSetAndRun  <c-r>=expand('%')<CR><s-left><left>", remap)

keymap.set('n', '<leader>tn', cmd.tabedit)
keymap.set('n', '<leader>ts', function () cmd('tab split') end)
keymap.set('n', '<leader>td', function () cmd.tcd('%:p:h') end)
keymap.set('n', '<leader>tc', cmd.tabclose)

for i=1,9 do
  keymap.set('n', '<m-'..i..'>', i..'gt')
end
keymap.set('n', '<m-0>', ':$tabnext<CR>')

opt.fileformats = 'unix,dos,mac'
opt.fileencodings = 'ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1'
opt.diffopt = 'internal,filler,vertical,iwhite,indent-heuristic,algorithm:histogram'
keymap.set('n', '<leader>du', cmd.diffupdate)

keymap.set('n', '<leader>f', cmd.Files)
keymap.set('n', '<leader>df', ":args `git status --porcelain=v1 <bslash><bar> awk '{print $2}'`<cr>")
keymap.set('n', '<leader>bf', cmd.Buffers)
keymap.set('n', '<leader>/', cmd.Lines)

keymap.set('x', 's', '<Plug>(nvim-surround-visual)', remap)

keymap.set('n', 'j', "v:count ? 'j' : 'gj'", {expr = true})
keymap.set('n', 'k', "v:count ? 'k' : 'gk'", {expr = true})

cmd.inoreabbrev('rt', 'return')

keymap.set('i', '<c-j>', '<c-g>U<down>')
keymap.set('i', '<c-k>', '<c-g>U<up>')
keymap.set('i', '<c-l>', '<c-g>U<right>')
keymap.set('i', '<c-e>', '<c-g>U<c-o>A')
keymap.set('i', '<c-a>', '<c-g>U<c-o>I')

keymap.set('n', '<F1>', '<nop>')
keymap.set('n', 'Q', '<nop>')
keymap.set('n', 'yu', '"+yiW')
keymap.set('', 'H', '^')
keymap.set('', 'L', '$')
keymap.set('n', '<tab>', '%', remap)
keymap.set('', '<c-9>', '<c-i>')

keymap.set('n', '<c-h>', '<c-w>h')
keymap.set('n', '<c-j>', '<c-w>j')
keymap.set('n', '<c-k>', '<c-w>k')
keymap.set('n', '<c-l>', '<c-w>l')

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
	keymap.set(mode, lhs, rhs,
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
