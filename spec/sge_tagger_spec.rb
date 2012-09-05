require 'sge_tagger'

describe SGETagger::Tagger do
  describe ".tag_text(og_text, file_type)" do
    let(:tagger) { SGETagger::Tagger.new }

    context 'untagged file' do
      it 'tags file' do
        og_text = "text in file"
        tagged_text = tagger.tag_text(og_text, '.txt')
        tagged_text.scan(SGETagger::LEGAL_INFO).count.should == 1
      end

      it 'properly tags .rb files' do
        og_text = "text in file"
        tagged_text = tagger.tag_text(og_text, '.rb')
        tagged_text.scan(SGETagger::LEGAL_INFO).count.should == 1
        tagged_text.index("=begin").should == 0
      end
    end

    context 'already tagged file' do
      it 'only tags once' do
        og_text = SGETagger::LEGAL_INFO
        tagged_text = tagger.tag_text(og_text, '.txt')
        tagged_text.scan(SGETagger::LEGAL_INFO).count.should == 1
      end
    end

    it 'does not modify original text' do
      og_text = SGETagger::LEGAL_INFO
      tagged_text = tagger.tag_text(og_text, '.txt')
      og_text.object_id.should_not == tagged_text.object_id
    end
  end

  describe "#tagged?(text)" do
    it 'true for tagged text' do
      text = SGETagger::LEGAL_INFO
      SGETagger::Tagger.tagged?(text).should be_true
    end

    it 'false for untagged text' do
      text = 'untagged text'
      SGETagger::Tagger.tagged?(text).should be_false
    end

    it 'ignores newlines' do
      text = SGETagger::LEGAL_INFO.gsub("\n", '')
      SGETagger::Tagger.tagged?(text).should be_true
    end
  end
end
