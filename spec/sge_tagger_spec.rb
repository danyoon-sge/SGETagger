require 'sge_tagger'

describe SGETagger do
  describe "#tag_text(og_text, file_type)" do
    it 'does not modify original text' do
      og_text = SGETagger::LEGAL_INFO
      tagged_text = SGETagger.tag_text(og_text, '.txt')
      og_text.should_not == tagged_text
    end
  end
end
