# Intro

My dotfiles.

## Points to Take

* I use [Neovim] and [Fish]
* Only tested on Linux. I used macOS briefly before.
* Relying on defaults to keep the config short

## Installation

Prerequisites:

* Git
* Rake

### Install Individual Files

`rake zshrc` creates symlink `~/.zshrc -> zshrc`
thanks to Ruby's expressiveness.

Well, you can't `rake README.markdown` anyway.

### Install & Update Neovim plugins

`rake update_nvim` installs all Neovim plugins & compile required tree-sitter
parsers.

You might need to run it with envvar `https_proxy=...`.

### Install individual scripts in bin/

`rake lnbin[toggle-dark-mode]`. If the command fails due to globing,
switch to fish from bash / zsh or wrap the argument with quotes.

## License

0BSD. See [LICENSE](./LICENSE) file for full license text.

[Neovim]: https://neovim.io/
[fish]: https://fishshell.com
