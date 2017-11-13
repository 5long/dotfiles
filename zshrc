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
SAVEHIST=8000
HISTFILE=~/.zsh_history
set -o histsavenodups

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -M vicmd H vi-first-non-blank
bindkey -M vicmd L vi-end-of-line

KEYTIMEOUT=1

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:mpv:argument*' tag-order - '! urls'
compdef _pacman pacaur=pacman

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
path=(
  $HOME/.local/bin
  $HOME/.yarn/bin
  $path
)

alias -g L='| less'
alias -g LC='--color=always | less'
alias -g G='| grep -E'

alias rake='noglob rake'

FZF_BINDING=/usr/share/fzf/key-bindings.zsh
test -f "$FZF_BINDING" && . "$FZF_BINDING"

mkqr_() {
  [[ -z "$1" ]] && return 1
  iv =(qrencode -s 10 -o - "$@")
}
alias mkqr='noglob mkqr_'

if [[ -s ~/.zshrc.local ]] then
  . ~/.zshrc.local
fi
