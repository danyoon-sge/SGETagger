# encoding: utf-8
require 'methadone'
require "sge_tagger/version"

module SGETagger
  LEGAL_INFO = <<-EOS
Confidential information of Sleepy Giant Entertainment, Inc.
© Sleepy Giant Entertainment, Inc.
  EOS

  def self.tag_legal(rfile)
    og_text = File.read(rfile)

    File.open(rfile, 'w') do |wfile|
      legal_text = LEGAL_INFO

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
