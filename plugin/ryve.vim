if exists("g:loaded_ryve") || &cp
    finish
endif
let g:loaded_ryve = 1

function! s:SearchByMotion(type, ...)
  silent exec 'normal! `[v`]y'
  let @/ = @"
  call search(@")
endfunction

function! s:ReplaceByMotion(type, ...)
  let l:replacement = @"
  silent exec 'normal! `[v`]d'
  let l:replaced = @"
  let @" = l:replacement
  silent exec 'normal! P'
  let @" = l:replaced
endfunction

nnoremap <silent> <Plug>SearchByMotion :<c-u>set opfunc=<SID>SearchByMotion<CR>g@
nnoremap <silent> <Plug>ReplaceByMotion :<c-u>set opfunc=<SID>ReplaceByMotion<CR>g@

if !hasmapto('<Plug>SearchByMotion', 'n')
  nmap <unique> g/ <Plug>SearchByMotion
endif

if !hasmapto('<Plug>ReplaceByMotion', 'n')
  nmap <unique> gr <Plug>ReplaceByMotion
endif
