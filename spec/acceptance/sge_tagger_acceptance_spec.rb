require 'sge_tagger'
require 'methadone'
require 'pry'

include Methadone::CLILogging
include Methadone::SH
include FileUtils

TEMP_DIR = 'tmp'

describe SGETagger do
  context 'dir /tmp does not exist' do
    before(:all) do
      if Dir.exists?(TEMP_DIR)
        rm_rf(TEMP_DIR)
      end
    end

    it 'exits with error' do
      code = sh "bundle exec sge_tagger #{TEMP_DIR}"
      code.should_not == 0
    end
  end
end
