HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile]
DOTFILES = Dir['*'] - BLACKLIST

DOTFILES.each do |f|
  task f do |t|
    target = "#{HOME}/.#{t.name}"
    source = "#{CWD}/#{t.name}"
    File.symlink source, target unless File.exists? target
  end
end

TMP_DIR = "#{HOME}/.tmp"
directory TMP_DIR
task :vimrc => TMP_DIR

VUNDLE_REPO = 'http://github.com/gmarik/vundle'
directory 'vim/bundle'
task :vundle => ['vim/bundle'] do |t|
  vundle_root = "vim/bundle/#{t.name}"
  sh "git clone #{VUNDLE_REPO} #{vundle_root}" unless File.exists? vundle_root
end

task :vim_plugins => [:vim, :vimrc, :vundle] do
  sh 'vim +BundleInstall +quitall'
end

task :command_t => :vim_plugins do
  RakeFileUtils.cd 'vim/bundle/Command-T/ruby/command-t' do
    ruby 'extconf.rb'
    sh 'make clean all'
  end
end

desc "Install w/o overwriting"
task :default => [:command_t, :zshrc]
