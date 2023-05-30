source ~/.commonshrc

autoload -U compinit promptinit
compinit
promptinit
prompt walters

set -o auto_cd
set -o csh_null_glob
set -o no_flow_control
set -o numeric_glob_sort

set -o hist_ignore_all_dups
set -o hist_reduce_blanks
SAVEHIST=100000
HISTFILE=~/.zsh_history
set -o extended_history inc_append_history_time
set -o histsavenodups

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -M vicmd H vi-first-non-blank
bindkey -M vicmd L vi-end-of-line

KEYTIMEOUT=1

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:mpv:argument*' tag-order - '! urls'

bindkey -v "^R" history-incremental-search-backward
bindkey -v "^Y" vi-put-after
bindkey -v "^A" beginning-of-line
bindkey -v "^E" end-of-line
bindkey -M vicmd "q" push-line
bindkey -M vicmd "u" undo
bindkey -M viins " " magic-space

PROMPT='%B%(?..[%?] )>%b '
REPORTTIME=15
typeset -U path

alias -g L='| less'
alias -g LC='--color=always | less'
alias -g G='| grep -E'

alias rake='noglob rake'
alias hist='fc -liD'

source_if_possible /usr/share/skim/key-bindings.zsh
source_if_possible /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export VIRTUALENVWRAPPER_WORKON_CD=1
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source_if_possible /usr/bin/virtualenvwrapper_lazy.sh

source_if_possible ~/.zshrc.local
