" Copied from https://github.com/vim-ruby/vim-ruby

if exists("current_compiler")
  finish
endif
let current_compiler = "minitest"

CompilerSet makeprg=RUBYLIB=lib:test\ ruby\ -rminitest/autorun

CompilerSet errorformat=
      \\ \ \ \ %f:%l:%m,
      \%W\ %\\+%\\d%\\+)\ Failure:,
      \%C%m\ [%f:%l]:,
      \%E\ %\\+%\\d%\\+)\ Error:,
      \%C%m:,
      \%Z\\s%#,
      \%+C%.%#,
      \%-G%.%#
