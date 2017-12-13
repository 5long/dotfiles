set suffixesadd=.js
inoreabbrev c const
inoreabbrev ec export const
inoreabbrev ed export default
inoreabbrev pps {...props}

inoreabbrev const YOUDONEMESSEDUP_JUST_TYPE_C_INSTEAD
inoreabbrev import SHAMEONYOUFORNOTUSING_IM_TAB

command! -buffer EFix !npx eslint --fix %
" Close tag
inoremap /. />
