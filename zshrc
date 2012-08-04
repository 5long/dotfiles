autoload -U compinit promptinit
compinit
promptinit
prompt walters

set -o vi
set -o auto_cd
set -o nonotify
set -o csh_null_glob
set -o no_flow_control
set -o numeric_glob_sort

set -o share_history
set -o hist_ignore_all_dups
set -o hist_reduce_blanks
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.zsh_history
set -o histsavenodups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey -v "^R" history-incremental-search-backward
bindkey -v "^Y" vi-put-after
bindkey -v "^A" beginning-of-line
bindkey -v "^E" end-of-line
bindkey -M vicmd "q" push-line
bindkey -M vicmd "u" undo
bindkey -M viins " " magic-space

export PS1='%B%(?..[%?] )>%b '
export PAGER=less
export N_PREFIX="$HOME/.local"
typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  $path
  $N_PREFIX/n/current/bin
)
export EDITOR=vim
export VISUAL=vim
export RLWRAP_EDITOR='vi +%L'
export CDPATH=".:$HOME:$HOME/code"
export BCAT_BROWSER=google-chrome
export PYTHONDONTWRITEBYTECODE=1

alias l=ls
alias ls='ls -F'
alias ll='ls -oh'
alias la='ls -A'

alias grep='grep --color=auto'
alias psg='ps aux | grep'
alias -g L='| less'
alias -g G='| grep'

alias be='bundle exec'
alias g=git
alias ht="htop -u $USER"
alias p=pacman
alias pa=packer
alias pr='padrino rake'
alias s='sudo -E '
alias svim='sudo vim'

cdgem() {
  cd $(dirname $(gem which $1))
}

[[ -s ~/.zshrc.local ]] && source ~/.zshrc.local
