# Check for an interactive session
[ -z "$PS1" ] && return

source ~/.commonshrc

PS1='[\u@\h \W]\$ '

shopt -s autocd

HISTFILE=~/.bash_history

if [[ -s ~/.bashrc.local ]]
then
  source ~/.bashrc.local
fi
