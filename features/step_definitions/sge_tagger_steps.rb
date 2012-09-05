Then /^the file "(.*?)" should be text\-tagged$/ do |file_dir|
  in_aruba_dir(file_dir) do
    filename = File.basename(file_dir)
    text = File.read(filename)
    text.index(SGETagger::LEGAL_INFO).should == 0
  end
end

Then /^the file "(.*?)" should be ruby\-tagged$/ do |file_dir|
  in_aruba_dir(file_dir) do
    filename = File.basename(file_dir)
    text = File.read(filename)
    text.index("=begin\n#{SGETagger::LEGAL_INFO}").should == 0
    text.include?(SGETagger::LEGAL_INFO).should be_true
  end
end

Then /^the file "(.*?)" should only be tagged once$/ do |file_dir|
  in_aruba_dir(file_dir) do
    filename = File.basename(file_dir)
    text = File.read(filename)

    # ignore \n to get an accurate count
    text.gsub!("\n", '')
    text.scan(SGETagger::LEGAL_INFO.gsub("\n", '')).count.should == 1
  end
end

Then /^the file "(.*?)" should be unchanged$/ do |file_dir|
  in_aruba_dir(file_dir) do
    filename = File.basename(file_dir)
    text = File.read(filename)
    text.include?(SGETagger::LEGAL_INFO).should be_false
  end
end
