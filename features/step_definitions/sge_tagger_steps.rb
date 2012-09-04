# encoding: utf-8
require 'pry'
include FileUtils

FILES =  %w[sge.sass sge.less sge.css sge.html sge.html.haml sge.html.erb]
FILES += %w[sge.rb sge.js]
FILES.uniq!

LEGAL_INFO = <<eot
Confidential information of Sleepy Giant Entertainment, Inc.
© Sleepy Giant Entertainment, Inc.
eot

Given /^a git repo with some SGE owned files at "(.*?)"$/ do |repo_dir|
  @repo_dir = repo_dir
  base_dir = File.dirname(repo_dir)
  dir = File.basename(repo_dir)
  Dir.chdir base_dir do
    rm_rf dir
    mkdir dir
  end
  Dir.chdir repo_dir do
    FILES.each { |file| sh "echo 'SGE owned file' >> #{file}" }
    sh "git init ."
    sh "git add #{FILES.join(' ')}"
    sh "git commit -a -m 'initial commit'"
  end
end

Then /^SGE owned files at "(.*?)" should be tagged with legal info$/ do |repo_dir|
  @repo_dir = repo_dir
  base_dir = File.dirname(repo_dir)
  dir = File.basename(repo_dir)
  Dir.chdir repo_dir do
    FILES.each do |file|
      text = File.read(file)
      text.index(LEGAL_INFO).should == 0
    end
  end
end
