function rn
  set -f fn $argv[1]

  echo $fn

  [ -z "$fn" ] && return 1
  [ -e "$fn" ] || return 2

  set -f cache (mktemp)

  echo "$fn" > "$cache"
  "$EDITOR" "$cache"
  mv "$fn" (cat "$cache")
end
