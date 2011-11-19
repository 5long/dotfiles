if exists("g:loaded_ryve") || &cp
  finish
endif
let g:loaded_ryve = 1

function! s:SearchByMotion(type, ...)
  let l:saved_unnamed_reg = @@
  silent normal! `[v`]y
  let l:search_term = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @/ = l:search_term
  let @@ = l:saved_unnamed_reg
endfunction

function! s:ReplaceByMotion(type, ...)
  silent normal! `[v`]p
endfunction

nnoremap <silent> <Plug>SearchByMotion :<c-u>set opfunc=<SID>SearchByMotion<CR>g@
nnoremap <silent> <Plug>ReplaceByMotion :<c-u>set opfunc=<SID>ReplaceByMotion<CR>g@

if !hasmapto('<Plug>SearchByMotion', 'n')
  nmap <unique> g/ <Plug>SearchByMotion
endif

if !hasmapto('<Plug>ReplaceByMotion', 'n')
  nmap <unique> gr <Plug>ReplaceByMotion
endif
