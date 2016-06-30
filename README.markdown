# Intro

My dotfiles.

## Points to Take

* I use [Neovim]
* Unix-y system
* Relying on defaults to keep the config short

## Installation

Prerequesistes:

* Git
* Rake

And...

    $ cd /path/for/this/repo
    $ rake

## Install Individual Files

`rake zshrc` could create symlink `~/.zshrc -> zshrc`
thanks to Ruby's expressivness.

Well, you can't `rake README.markdown` anyway.

## License

Public domain. See UNLICENSE

[Neovim]: http://neovim.io/
