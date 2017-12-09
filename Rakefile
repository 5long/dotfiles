HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile UNLICENSE bin]
DOTFILES = FileList['*'] - BLACKLIST

XDG_DIRS = %w[nvim git alacritty termite rofi pacman dunst]
def xdg_target(name)
  XDG_DIRS.include?(name) ? "#{HOME}/.config/#{name}" : nil
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

VIM_PLUG_FILENAME = 'nvim/autoload/plug.vim'
task 'vim-plug' do
  if not File.exist? VIM_PLUG_FILENAME
    sh "curl -fkLo #{VIM_PLUG_FILENAME} \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  end
end

desc "Install vim plugins via vim-plug"
task :vim_plugins => [:nvim, 'vim-plug'] do
  sh 'nvim --headless +PlugInstall +qall'
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
  eslint
  serve
  eslint-config-airbnb
  eslint-config-prettier
  eslint-plugin-import
  eslint-plugin-jsx-a11y
  eslint-plugin-react
  eslint-import-resolver-babel-plugin-root-import
  javascript-typescript-langserver
  neovim
]
desc "Install essential NodeJS packages"
task :npm do
  sh(*%w[npm i -g yarn])
  sh(*(%w[yarn global add eslint ].concat(NODE_PKGS)))
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
