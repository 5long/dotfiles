function edbin
  set -f file (type -P $argv[1])

  if test -r $file
    $EDITOR $file
  else
    echo "Can't read file $file"
  end
end
