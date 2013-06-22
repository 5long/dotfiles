compiler pytest
let b:ragain_cmd = "!PYTHONPATH=. python " . expand("%")
nnoremap <leader>T :RagainSetAndRun !PYTHONPATH=. py.test =expand("%")<CR><CR>
