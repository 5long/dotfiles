nnoremap <buffer> <leader>vi :call VimuxOpenInterpreter("csi")<cr>
nnoremap <buffer> <leader>vl :call VimuxSendExpr(",ln " . expand("%"))<cr>
