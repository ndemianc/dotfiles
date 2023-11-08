#!/usr/bin/env ruby

git_bundles = [
  'git@github.com:rking/ag.vim.git',
  'git@github.com:ctrlpvim/ctrlp.vim.git',
  'git@github.com:preservim/nerdtree.git',
  'git@github.com:tomtom/tlib_vim.git',
  'git@github.com:tpope/vim-commentary.git',
  'git@github.com:tpope/vim-fugitive.git',
  'git@github.com:tpope/vim-rails.git',
  'git@github.com:tpope/vim-rhubarb.git',
  'git@github.com:vim-ruby/vim-ruby.git',
  'git@github.com:tpope/vim-surround.git',
  'git@github.com:flazz/vim-colorschemes.git'
].freeze

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.expand_path('~'), ".vim/pack/bundle/start")

unless File.directory?(bundles_dir)
  FileUtils.mkdir_p(bundles_dir)
end

FileUtils.cd(bundles_dir) do
  puts "REMOVING EVERYTHING INSIDE (#{bundles_dir})"
  Dir["*"].each {|d| FileUtils.rm_rf d }

  git_bundles.each do |url|
    dir = url.split('/').last.sub(/\.git$/, '')
    puts "  Unpacking #{url} into #{dir}"
    `git clone #{url} #{dir}`
    FileUtils.rm_rf(File.join(dir, ".git"))
  end
end



# Install tmux-themepack
tmux_themepack = File.join(File.expand_path('~'), ".tmux-themepack")
if File.directory?(tmux_themepack)
  FileUtils.rm_rf(tmux_themepack)
end
`git clone https://github.com/jimeh/tmux-themepack.git #{tmux_themepack}`

# Copy .tmux.conf
`cp .tmux.conf ~/.tmux.conf`

# Copy .vimrc
`cp .vimrc ~/.vimrc`

# Copy .gemrc
`cp .gemrc ~/.gemrc`
