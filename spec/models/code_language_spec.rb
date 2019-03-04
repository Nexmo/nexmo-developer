require 'rails_helper'

RSpec.describe CodeLanguage, type: :model do
  let(:language) { CodeLanguage.new }

  describe '#weight' do
    it 'returns a default value' do
      expect(language.weight).to eq(999)
    end
  end

  describe '#linkable?' do
    it 'returns true' do
      expect(language.linkable?).to eq(true)
    end

    context 'with the linkable attribute set to false' do
      let(:language) { CodeLanguage.new(linkable: false) }

      it 'returns false' do
        expect(language.linkable?).to eq(false)
      end
    end
  end

  describe '#lexer' do
    let(:language) { CodeLanguage.new(lexer: 'ruby') }

    it 'returns a rouge lexer' do
      expect(language.lexer).to eq(Rouge::Lexers::Ruby)
    end
  end

  describe '#languages' do
    let(:language) { CodeLanguage.new(languages: %w[swift objective_c]) }
    let(:languages) { language.languages }

    it 'returns an array of code languages' do
      expect(languages).to be_an(Array)
      expect(languages[0]).to be_a(CodeLanguage)
      expect(languages[0].key).to eq('swift')
      expect(languages[1]).to be_a(CodeLanguage)
      expect(languages[1].key).to eq('objective_c')
    end
  end
end
