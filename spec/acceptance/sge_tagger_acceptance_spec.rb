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
end
