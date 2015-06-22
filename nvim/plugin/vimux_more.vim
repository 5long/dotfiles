function! VimuxOpenInterpreter(interpreter)
  silent! call VimuxOpenPane()
  call VimuxRunCommand(a:interpreter)
endfunction

function! VimuxSendExpr(e)
  call VimuxRunCommand(substitute(a:e, "\\\n$", "", ""))
endfunction
