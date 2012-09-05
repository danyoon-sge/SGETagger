require 'sge_tagger'

describe SGETagger do
  describe "#tag_text(og_text, file_type)" do
    let(:tagger) { SGETagger::Tagger.new }

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

=begin
  describe "#new_count" do
    it 'return 0 when empty' do
      SGETagger.new_count.should == 0
    end
  end

  describe "#prev_count" do
    it 'return 0 when empty' do
      SGETagger.prev_count.should == 0
    end
  end

  describe "#ignored_count" do
    it 'return 0 when empty' do
      SGETagger.ignored_count.should == 0
    end
  end

  describe "#inc_new_count" do
    it 'increments new_count' do
      pending
      count = SGETagger.new_count
      SGETagger.inc_new_count
      count.next.should == SGETagger.new_count
    end
  end
=end
end
