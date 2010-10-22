# Intro

My vim runtime files.

## Points to Take

* For VIM 7.3 only
* Unix-y system
* Mostly I do JavaScript
* Relying on defaults to keep it short (e.g. no `set nocp`)

## Installation

Ruby headers for Command-T

    $ vim --version | perl -e 'while(<>) {print $1 if (m/-lruby-?([\d.]+)/)}'
    1.9.1
    $ aptitude install ruby1.9.1-dev

Backup

    $ cd ~
    $ mv .vimrc .vimrc_backup
    $ mv .vim .vim_backup

Install

    $ cd /path/for/this/repo
    $ make all

If you are on a Windows box, may God watch over you.

## Plugins Included

* AutoComplPop
* Command-T
* minibufexpl.vim
* snipMate
* surround.vim
