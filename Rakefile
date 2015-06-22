HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile UNLICENSE]
DOTFILES = FileList['*'] - BLACKLIST

DOTFILES.each do |f|
  desc "Install ~/.#{f} by symlinking"
  task f do |t|
    target = "#{HOME}/.#{t.name}"
    source = "#{CWD}/#{t.name}"
    File.symlink source, target unless File.exists? target
  end
end

task :bashrc => :commonshrc
task :zshrc => :commonshrc

TMP_DIR = "#{HOME}/.tmp"
directory TMP_DIR
task :vimrc => TMP_DIR

VIM_PLUG_FILENAME = 'vim/autoload/plug.vim'
directory 'vim/autoload'
task 'vim-plug' => ['vim/autoload'] do
  if not File.exist? VIM_PLUG_FILENAME
    sh "curl -fkLo #{VIM_PLUG_FILENAME} --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  end
end

desc "Install vim plugins via vim-plug"
task :vim_plugins => [:vim, :vimrc, 'vim-plug'] do
  sh 'vim +PlugInstall +quitall'
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

desc "Install everything"
task :everything => DOTFILES
task :default => :everything
