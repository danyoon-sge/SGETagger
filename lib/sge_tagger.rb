# encoding: utf-8
require 'methadone'
require "sge_tagger/version"
require 'pry'

module SGETagger
  LEGAL_INFO = <<-EOS
Confidential information of Sleepy Giant Entertainment, Inc.
© Sleepy Giant Entertainment, Inc.
  EOS

  def self.tag_file(rfile)
    og_text = File.read(rfile)
    tagged_text = tag_text(og_text, File.extname(rfile))

    File.open(rfile, 'w') do |wfile|
      wfile.puts tagged_text
    end
  end

  def self.tag_text(og_text, file_type)
    tagged_text = LEGAL_INFO.clone

    case file_type
    when '.rb'
      tagged_text.insert(0, "=begin\n")
      tagged_text << "=end\n"
    end

    tagged_text << og_text
    tagged_text
  end
end
