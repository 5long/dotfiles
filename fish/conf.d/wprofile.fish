function should_launch_sway
  status is-login && test "$XDG_SESSION_TYPE" = tty && test "$XDG_VTNR" = "1"
end

if not should_launch_sway
  exit
end

set -gx XMODIFIERS @im=fcitx
set -gx QT_AUTO_SCREEN_SCALE_FACTOR 1
set -gx QT_QPA_PLATFORMTHEME qt6ct
set -gx SDL_VIDEODRIVER wayland
set -gx XCURSOR_SIZE 48
set -gx XCURSOR_THEME Bibata-Original-Classic
set -gx WPROFILE YES

function launch_sway
  exec uwsm start sway.desktop
end
