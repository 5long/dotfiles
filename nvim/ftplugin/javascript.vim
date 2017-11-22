set suffixesadd=.js
inoreabbrev c const
inoreabbrev ec export const
inoreabbrev ed export default
inoreabbrev const YOUDONEMESSEDUP_JUST_TYPE_C_INSTEAD
inoreabbrev import SHAMEONYOUFORNOTUSING_IM_TAB

command! -buffer EFix !npx eslint --fix %
" Close tag
inoremap /. />

augroup vimrc_javascript
  autocmd!
  autocmd InsertEnter * set signcolumn=no
  autocmd InsertLeave * set signcolumn=auto
augroup end
