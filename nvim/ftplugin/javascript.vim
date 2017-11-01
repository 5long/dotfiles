set suffixesadd=.js

command! -buffer EFix !npx eslint --fix %
" Close tag
inoremap /. />
