#!/usr/bin/env ruby

git_bundles = [
  'git@github.com:rking/ag.vim.git',
  'git@github.com:ctrlpvim/ctrlp.vim.git',
  'git@github.com:yegappan/mru.git',
  'git@github.com:scrooloose/syntastic.git',
  'git@github.com:tpope/vim-commentary.git',
  'git@github.com:tpope/vim-fugitive.git',
  'git@github.com:tpope/vim-rails.git',
  'git@github.com:ecomba/vim-ruby-refactoring.git',
  'git@github.com:vim-ruby/vim-ruby.git',
  'git@github.com:tpope/vim-surround.git',
  'git@github.com:garbas/vim-snipmate.git'
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

unless File.directory?(bundles_dir)
  FileUtils.mkdir_p(bundles_dir)
end

FileUtils.cd(bundles_dir)

puts "REMOVING EVERYTHING INSIDE (#{bundles_dir})"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end
