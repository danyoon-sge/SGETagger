require 'sge_tagger'

describe SGETagger do
  describe "#tag_text(og_text, file_type)" do
    context 'already tagged file' do
      it 'only tags once' do
        og_text = SGETagger::LEGAL_INFO
        tagged_text = SGETagger.tag_text(og_text, '.txt')
        tagged_text.scan(SGETagger::LEGAL_INFO).count.should == 1
      end
    end

    it 'does not modify original text' do
      og_text = SGETagger::LEGAL_INFO
      tagged_text = SGETagger.tag_text(og_text, '.txt')
      og_text.object_id.should_not == tagged_text.object_id
    end
  end
end