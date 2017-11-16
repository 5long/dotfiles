set suffixesadd=.js
inoreabbrev c const
inoreabbrev const YOUDONEMESSEDUP_JUST_TYPE_C_INSTEAD

command! -buffer EFix !npx eslint --fix %
" Close tag
inoremap /. />
