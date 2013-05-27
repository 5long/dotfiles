source ~/.commonshrc

autoload -U compinit promptinit
compinit
promptinit
prompt walters

set -o auto_cd
set -o csh_null_glob
set -o no_flow_control
set -o numeric_glob_sort

set -o share_history
set -o hist_ignore_all_dups
set -o hist_reduce_blanks
SAVEHIST=2000
HISTFILE=~/.zsh_history
set -o histsavenodups

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -M vicmd H vi-first-non-blank
bindkey -M vicmd L vi-end-of-line

KEYTIMEOUT=1

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey -v "^R" history-incremental-search-backward
bindkey -v "^Y" vi-put-after
bindkey -v "^A" beginning-of-line
bindkey -v "^E" end-of-line
bindkey -M vicmd "q" push-line
bindkey -M vicmd "u" undo
bindkey -M viins " " magic-space

PROMPT='%B%(?..[%?] )>%b '
typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  $path
)

export BCAT_BROWSER=google-chrome
export XAPIAN_CJK_NGRAM=1

alias -g L='| less'
alias -g G='| grep'

alias rake='noglob rake'
alias zathura='zathura --fork &>/dev/null'
alias irc='weechat-curses'
alias turn='turn --natural'

if [[ -s ~/.zshrc.local ]] then
  source ~/.zshrc.local
fi
