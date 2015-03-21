# Intro

My dotfiles.

## Points to Take

* For VIM 7.3 only
* Unix-y system
* Relying on defaults to keep it short (e.g. no `set nocp`)

## Installation

Prerequesistes:

* Git
* Rake
* Ruby headers (for Command-T)

And...

    $ cd /path/for/this/repo
    $ rake

## Install Individual Files

`rake zshrc` could create symlink `~/.zshrc -> zshrc`
thanks to Ruby's expressivness.

Well, you can't `rake README.markdown` anyway.

## License

Public domain. See UNLICENSE
