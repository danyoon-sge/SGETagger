Then /^the file "(.*?)" should be tagged$/ do |file_dir|
  in_aruba_dir(file_dir) do
    filename = File.basename(file_dir)
    text = File.read(filename)
    text.index(SGETagger::LEGAL_INFO).should == 0
  end
end
