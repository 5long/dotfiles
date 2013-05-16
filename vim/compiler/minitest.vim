" Copied from https://github.com/vim-ruby/vim-ruby

if exists("current_compiler")
  finish
endif
let current_compiler = "minitest"

CompilerSet makeprg=RUBYLIB='lib:test'\ ruby

CompilerSet errorformat=\%W\ %\\+%\\d%\\+)\ Failure:,
      \%C%m\ [%f:%l]:,
      \%E\ %\\+%\\d%\\+)\ Error:,
      \%C%m:,
      \%C\ \ \ \ %f:%l:%.%#,
      \%C%m,
      \%Z\ %#,
      \%-G%.%#
