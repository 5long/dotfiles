if status is-login && test "$ENVD" != "yes"
  source (
    /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator \
    | sed -e 's/^/export /' \
    | psub
  )
end
