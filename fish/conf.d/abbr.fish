if not status is-interactive
  exit
end

function hpxy
  https_proxy=$PXY http_proxy=$PXY $argv
end

abbr dg doggo --time --timeout 3s
abbr e nvim
abbr fw firewall-cmd
abbr g git
abbr ge gnome-text-editor
abbr ht htop -u \$USER -s PERCENT_CPU
abbr ip ip -h -br -c=auto
abbr j journalctl -o short-iso
abbr jfu journalctl -f --unit
abbr l ls
abbr la ls -A
abbr ll ls -oh
alias ls='ls -F --group-directories-first --color --hyperlink --time-style=iso'
abbr ntw networkctl
abbr o xdg-open
abbr p sudo pacman
abbr pa paru
abbr pu sudo pacman -Syu
alias rg='rg -LS --no-require-git'
abbr rsv resolvectl
abbr s systemctl
abbr scu systemctl --user
abbr v less
abbr z bsdtar

abbr -a CL --position anywhere --set-cursor=% -- "--color=always % | less"
abbr -a L --position anywhere --set-cursor "% | less"
abbr -a G --position anywhere "| rg"
