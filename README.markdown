# Intro

My vim runtime files.

## Points to Take

* For VIM 7.3 only
* Unix-y system
* Mostly I do JavaScript
* Relying on defaults to keep it short (e.g. no `set nocp`)

## Installation

Ruby headers for Command-T:

    $ vim --version | perl -ne 'print "$1\n" if m/ruby-?([\d.]+)/'
    1.9.1
    $ aptitude install ruby1.9.1-dev

Also make sure [git](http://git-scm.org/) is in $PATH, which is required by
Vundle.

Here comes the install if you're not scared by the messy Makefile.

    $ cd /path/for/this/repo
    $ make all

Be sure to backup `~/.vim` and `~/.vimrc`.

If you are on a Windows box, may God watch over you.

## On Plugins

I dont' use that many plugins these days, but I'll surely try something new
since Vundle makes it too easy. snipMate is included since I don't really
need that many snippets distributed with it. For a full list of plugins,
search .vimrc for `Bundle`.
