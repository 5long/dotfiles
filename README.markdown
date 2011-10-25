# Intro

My vim runtime files.

## Points to Take

* For VIM 7.3 only
* Unix-y system
* Mostly I do JavaScript
* Relying on defaults to keep it short (e.g. no `set nocp`)

## Installation

Ruby headers for Command-T

    $ vim --version | perl -ne 'print "$1\n" if m/ruby-?([\d.]+)/'
    1.9.1
    $ aptitude install ruby1.9.1-dev

Install

    $ cd /path/for/this/repo
    $ make all

Be sure to backup `~/.vim`, `~/.vimrc` and `~/.gvimrc`.

If you are on a Windows box, may God watch over you.

## Plugins Included

* AutoComplPop
* Command-T
* snipMate
* surround.vim
* ack.vim
