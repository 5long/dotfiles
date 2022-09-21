HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile UNLICENSE bin]
DOTFILES = FileList['*'] - BLACKLIST

XDG_ENTIRES = %w[fontconfig cnvim git alacritty termite rofi pacman dunst zathura bat pip pylintrc yamllint]
def xdg_target(name)
  XDG_ENTIRES.include?(name) ? "#{HOME}/.config/#{name}" : nil
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
    File.symlink source, target unless File.exists? target
  end
end

task :bashrc => :commonshrc
task :zshrc => :commonshrc
task :commonshrc => :commonenv

NVIM_PACKER_PATH = File.expand_path "~/.local/share/nvim/site/pack/packer/start"
desc "Install packer.nvim"
task 'nvim-packer' do
  if not File.exist? "#{NVIM_PACKER_PATH}/packer.nvim/.git"
    mkdir_p NVIM_PACKER_PATH
    sh %[
      git clone --depth 1 \
      https://github.com/wbthomason/packer.nvim \
      ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    ]
  end
end

desc "Vimrc for old Vim"
task :old_vim do
  source = "#{CWD}/nvim"
  target = "#{HOME}/.vim"
  File.symlink source, target unless File.exists? target
end

desc "Take a dotfile from $HOME"
task :take, :dotless_name do |t, args|
  dotless = args[:dotless_name]
  filename = ".#{dotless}"
  full_path = "#{HOME}/#{filename}"
  next unless File.exists? full_path
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
]
desc "Install essential NodeJS packages"
task :npm do
  sh(*%w[npm i -g yarn])
  sh(*(%w[yarn global add].concat(NODE_PKGS)))
end

desc "Install every bin/* into ~/.local/bin"
task :bin do
  FileList['bin/*'].each do |f|
    begin
      ln f, "#{HOME}/.local/bin"
    rescue Errno::EEXIST
      puts "#{HOME}/.local/#{f} already exists" if verbose == true
    else
      true
    end
  end
end

desc "Link a ~/.local/bin/<file> to ./bin"
task :lnbin, :fn do |t, args|
  ln "#{HOME}/.local/bin/#{args[:fn]}", "./bin/"
end

desc "Install everything"
task :everything => DOTFILES + [:bin]
task :default => :everything
