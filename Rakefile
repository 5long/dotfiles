HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile]
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

VUNDLE_REPO = 'http://github.com/Shougo/neobundle.vim'
directory 'vim/bundle'
task :'neobundle.vim' => ['vim/bundle'] do |t|
  vundle_root = "vim/bundle/#{t.name}"
  sh "git clone #{VUNDLE_REPO} #{vundle_root}" unless File.exists? vundle_root
end

desc "Install vim plugins via Vundle"
task :vim_plugins => [:vim, :vimrc, :'neobundle.vim'] do
  sh 'vim +NeoBundleInstall +quitall'
end

desc "Compiler Command-T (requires Ruby support in Vim)"
task :command_t => :vim_plugins do
  cd 'vim/bundle/Command-T/ruby/command-t' do
    ruby 'extconf.rb'
    sh 'make clean all'
  end
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
task :default => (DOTFILES.clone << :command_t)
