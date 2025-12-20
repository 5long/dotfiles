function fish_prompt
  # Save it for later display
  set -l last_status $status

  set -l symbol '> '
  set -l color $fish_color_cwd
  if fish_is_root_user
    set symbol '# '
    set -q fish_color_cwd_root
    and set color $fish_color_cwd_root
  end

  echo -n $USER@$hostname

  set_color $color
  echo -n "" (prompt_pwd)
  set_color normal

  if test $last_status -ne 0
    set_color $fish_color_error
    echo -n " [$last_status]"
    set_color normal
  end

  echo -n $symbol
end
