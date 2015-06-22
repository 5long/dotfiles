if (exists("b:did_custom_ftplugin"))
  finish
endif
let b:did_custom_ftplugin = 1

let b:surround_100 = "def\n\t\r\nend" " d
let b:surround_114 = "do\n\t\r\nend" " r
let b:surround_109 = "module\n\t\r\nend" " m
let b:surround_99 = "class\n\t\r\nend" " c

compiler minitest

func! s:run()
  return "!ruby -Ilib:test " . expand("%")
endfunc
let b:ragain_cmd = function("s:run")
