compiler pytest
fun! s:run()
  return "!PYTHONPATH=. python " . expand("%")
endfun
let b:ragain_cmd = function("s:run")

nnoremap <buffer> <leader>vi :call VimuxOpenInterpreter("ipython")<cr>
nnoremap <buffer> <leader>vl :call VimuxSendExpr("%loadpy " . expand("%"))<cr>
