# frozen_string_literal: true

HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile LICENSE bin].freeze
DOTFILES = FileList['*'] - BLACKLIST

XDG_ENTRIES = %w[
  fish
  fuzzel
  fontconfig
  foot
  fzfrc
  nvim
  git
  alacritty
  termite
  rofi
  rubocop
  pacman
  zathura
  bat
  pip
  pylintrc
  sequoia
  uv
  xh
  yamllint
  jj
].freeze
def xdg_target(name)
  XDG_ENTRIES.include?(name) ? "#{HOME}/.config/#{name}" : nil
end

def regular_dotfile(name)
  "#{HOME}/.#{name}"
end

def target_for(source)
  xdg_target(source) or regular_dotfile(source)
end

def tildify_path(path)
  path.sub(HOME, '~')
end

DOTFILES.each do |f|
  desc "Install #{tildify_path(target_for(f))} by symlinking"
  task f do |t|
    source = "#{CWD}/#{t.name}"
    target = target_for(t.name)
    File.symlink source, target unless File.exist? target
  end
end

task bashrc: :commonshrc
task zshrc: :commonshrc
task commonshrc: :commonenv

desc 'Take a dotfile from $HOME'
task :take, :dotless_name do |_, args|
  dotless = args[:dotless_name]
  filename = ".#{dotless}"
  full_path = "#{HOME}/#{filename}"
  next unless File.exist? full_path

  if File.symlink? full_path
    puts "#{full_path} is a symlink, not taken."
    next
  end
  mv full_path, dotless
end

NODE_PKGS = %w[
  browser-sync
  eslint
  serve
  eslint-config-airbnb
  eslint-config-prettier
  eslint-plugin-import
  eslint-plugin-jsx-a11y
  eslint-plugin-react
  eslint-import-resolver-babel-plugin-root-import
  import-js
  javascript-typescript-langserver
  neovim
].freeze

desc 'Install essential NodeJS packages'
task :npm do
  sh(*%w[npm i -g wrangler])
end

desc 'Install every bin/* into ~/.local/bin'
task :bin do
  FileList['bin/*'].each do |f|
    ln f, "#{HOME}/.local/bin"
  rescue Errno::EEXIST
    puts "#{HOME}/.local/#{f} already exists" if verbose == true
  else
    true
  end
end

desc 'Link a ~/.local/bin/<file> to ./bin'
task :lnbin, :fn do |_, args|
  fn = args[:fn]
  begin
    ln "#{CWD}/bin/#{fn}", "#{HOME}/.local/bin/"
  rescue Errno::EEXIST
    puts "#{HOME}/.local/#{fn} already exists" if verbose == true
  end
end

desc 'Update Neovim Plugins (probably needs https_proxy)'
task :update_nvim do
  sh 'nvim', '--headless', \
    "+lua vim.pack.update(nil, { target = 'lockfile', force = true })", \
    "+lua require('nvim-treesitter').update():wait(600000)", \
    '+qa'
end

desc 'Install everything'
task everything: DOTFILES + [:bin]
task default: :everything
