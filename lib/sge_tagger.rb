# encoding: utf-8
require 'methadone'
require "sge_tagger/version"
require 'pry'

module SGETagger
  class << self
    attr_reader :new_count, :prev_count, :ignored_count
  end

  LEGAL_INFO = <<-EOS
Confidential information of Sleepy Giant Entertainment, Inc.
© Sleepy Giant Entertainment, Inc.
  EOS

  def self.tag_file(rfile)
    og_text = File.read(rfile)
    tagged_text = tag_text(og_text, File.extname(rfile))

    if og_text != tagged_text
      File.open(rfile, 'w') do |wfile|
        wfile.puts tagged_text
      end
    end
  end

  def self.tag_text(og_text, file_type)
    return og_text.clone if SGETagger.tagged?(og_text)

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

  def self.new_count
    @new_count || 0
  end

  def self.prev_count
    @prev_count || 0
  end

  def self.ignored_count
    @ignored_count || 0
  end
end
