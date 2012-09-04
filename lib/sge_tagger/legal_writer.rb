module SGETagger
  class LegalWriter
    include Methadone::Main
    include Methadone::CLILogging
    include Methadone::SH

    def self.tag_legal(rfile, og_text)
      File.open(rfile, 'w') do |wfile|
        legal_text = SGETagger::LEGAL_INFO

        case File.extname(rfile)
        when '.rb'
          legal_text.insert(0, "=begin\n")
          legal_text << "=end\n"
        end

        wfile.puts legal_text
        wfile.puts og_text
      end
    end
  end
end
