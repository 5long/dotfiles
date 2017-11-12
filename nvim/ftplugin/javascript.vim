set suffixesadd=.js
iabbrev c const

command! -buffer EFix !npx eslint --fix %
" Close tag
inoremap /. />
