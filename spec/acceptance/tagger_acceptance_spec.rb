require 'sge_tagger'

include SGETagger

describe Tagger do
  TEMP_DIR = 'tmp'
  DIR1 = 'dir1'

  context 'tmp dir containing one file and one dir' do
    before(:each) do
      # make a dir containing one file and one dir
      FileUtils.rm_rf(TEMP_DIR)
      Dir.mkdir TEMP_DIR
      Dir.chdir TEMP_DIR do
        File.open('sge.txt', 'w+') { |file| file << "sge owned" }
        Dir.mkdir(DIR1)
      end
    end

    after(:each) do
      Dir.chdir '..'
      FileUtils.rm_rf(TEMP_DIR)
    end

    describe "#taggable_files" do
      it 'does not count directories' do
        tf = Tagger.taggable_files(TEMP_DIR)
        tf.count.should == 1
      end

      context 'file nested in a dir' do
        it 'includes files in nested dir' do
          # add folder one level down
          file = File.join(TEMP_DIR, DIR1)
          file = File.join(file, "inner_file.txt")
          File.open(file, 'w+') { |f| f << "inner file" }

          tf = Tagger.taggable_files(TEMP_DIR)
          tf.count.should == 2
        end
      end
    end

    after(:each) do
      Dir.chdir '..'
      FileUtils.rm_rf(TEMP_DIR)
    end

    describe "#taggable_files" do
      it 'does not count directories' do
        tf = Tagger.taggable_files(TEMP_DIR)
        tf.count.should == 1
      end

      context 'file nested in a dir' do
        it 'includes files in nested dir' do
          # add folder one level down
          file = File.join(TEMP_DIR, DIR1)
          file = File.join(file, "sge_inside_folder.txt")
          File.open(file, 'w+') { |f| f << "sge inside folder" }

          tf = Tagger.taggable_files(TEMP_DIR)
          tf.count.should == 2
        end
      end
    end
  end
end
