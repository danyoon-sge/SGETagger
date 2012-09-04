require 'sge_tagger'
require 'methadone'
require 'pry'

include Methadone::CLILogging
include Methadone::SH
include FileUtils

TEMP_DIR = 'tmp'

describe SGETagger do
  context 'passed in dir does not exist' do
    it 'exits with error' do
      code = sh "bundle exec sge_tagger non_existing_dir"
      code.should_not == 0
    end
  end

  context 'dir /tmp with SGE owned files' do
    before(:each) do
      # setup the tmp dir with files
      FILES = %w[sge.sass sge.less sge.css sge.html sge.html.haml sge.html.erb sge.rb sge.js]

      rm_rf TEMP_DIR
      mkdir TEMP_DIR

      Dir.chdir(TEMP_DIR) do
        FILES.each do |fname|
          sh "echo 'SGE owned file' >> #{fname}"
        end
      end
    end

    after(:each) do
      rm_rf TEMP_DIR
    end

    describe "execute 'sge_tagger tmp'" do
      it 'tags SGE files with legal info' do
        sh "bundle exec bin/sge_tagger #{TEMP_DIR}"
        Dir.chdir(TEMP_DIR) do
          Dir["**/*"].each do |file|
            text = File.read(file)
            text.include?('some legal stuff').should be_true
          end
        end
      end
    end
  end
end
