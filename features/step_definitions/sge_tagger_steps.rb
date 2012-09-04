Given /^a directory with SGE owned files at "(.*?)"$/ do |folder_dir|
  FILES = %w[sge.sass sge.less]

  base_dir = File.dirname(folder_dir)
  dir = File.basename(folder_dir)
  Dir.chdir base_dir do
    rm_rf dir
    mkdir dir
  end
  Dir.chdir folder_dir do
    FILES.each { |_| touch _ }
  end
end

Then /^SGE owned files at "(.*?)" should be tagged with legal info$/ do |folder_dir|
  Dir["#{folder_dir}/**"].each do |file|
    text = File.read(file)
    text.include?(SGETagger::LEGAL_INFO).should be_true
  end
end
