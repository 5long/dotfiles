set -gx PAGER less
set -gx LESS -FXRi
set -gx GREP_COLOR 'mt=1;32'
set -gx WATCH_INTERVAL 0.5

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx SKIM_DEFAULT_COMMAND 'rg --files --no-require-git'
set -gx SKIM_DEFAULT_OPTIONS '--color=light'
set -gx SKIM_CTRL_T_OPTS '--preview="bat -p {}"'
set -gx MTR_OPTIONS '-n -t'

set CDPATH . $HOME $HOME/src
