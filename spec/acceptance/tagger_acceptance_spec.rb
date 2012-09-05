require 'sge_tagger'

include SGETagger

describe Tagger do
  before(:each) do
    Dir.mkdir "tmp"
    Dir.chdir "tmp" do
      FileUtils.rm_rf("level_one")
      File.open('sge.txt', 'w+') { |file| file << "sge owned" }
      Dir.mkdir("level_one")
    end
  end

  after(:each) do
    FileUtils.rm_rf("tmp")
  end

  describe "#taggable_files" do
  end
end