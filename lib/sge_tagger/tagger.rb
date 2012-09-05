module SGETagger
  class Tagger
    include Methadone::Main
    include Methadone::CLILogging
    include Methadone::SH

    attr_reader :new_count, :prev_count, :ignored_count

    def initialize
      @new_count = 0
      @prev_count = 0
      @ignored_count = 0
    end

    def self.taggable_files(file_dir)
      Dir.chdir(file_dir) do
        Dir["**/*"].each do |rfile|
          yield rfile
        end
      end
    end

    def tag_file(rfile)
      og_text = File.read(rfile)
      tagged_text = tag_text(og_text, File.extname(rfile))

      if og_text != tagged_text
        @new_count += 1

        File.open(rfile, 'w') do |wfile|
          wfile.puts tagged_text
        end
      else
        @prev_count += 1
      end
    end
    
    def tag_text(og_text, file_type)
      return og_text.clone if Tagger.tagged?(og_text)

      tagged_text = LEGAL_INFO.clone

      case file_type
      when '.rb'
        tagged_text.insert(0, "=begin\n")
        tagged_text << "=end\n"
      end

      tagged_text << og_text
      tagged_text
    end

    def self.tagged?(text)
      text.gsub!("\n", '')
      text.include?(LEGAL_INFO.gsub("\n", ''))
    end
  end
end
