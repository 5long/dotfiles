function cdrb -a gem
  cd (dirname (gem which $gem))
end

abbr be bundle exec
