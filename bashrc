# Check for an interactive session
[ -z "$PS1" ] && return

. ~/.commonshrc

PS1='[\u@\h \W]\$ '

shopt -s autocd

HISTFILE=~/.bash_history

if [[ -s ~/.bashrc.local ]]
then
  . ~/.bashrc.local
fi
