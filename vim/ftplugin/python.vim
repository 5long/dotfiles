compiler pytest
fun! s:run()
  return "!PYTHONPATH=. python " . expand("%")
endfun
let b:ragain_cmd = function("s:run")
