require 'rails_helper'

RSpec.describe CodeLanguageResolver do
  describe '#languages' do
    it 'returns an array of CodeLanguage' do
      expect(CodeLanguageResolver.languages).to be_kind_of(Array)
      expect(CodeLanguageResolver.languages[0]).to be_kind_of(CodeLanguage)
    end
  end

  describe '#find?' do
    it 'returns a language' do
      expect(CodeLanguageResolver.find('ruby')).to be_kind_of(CodeLanguage)
    end

    it 'returns a platform' do
      expect(CodeLanguageResolver.find('ios')).to be_kind_of(CodeLanguage)
    end

    it 'returns a terminal_program' do
      expect(CodeLanguageResolver.find('curl')).to be_kind_of(CodeLanguage)
    end

    context 'when given an invalid key' do
      it 'returns nil' do
        expect { CodeLanguageResolver.find('foobar') }.to raise_exception('Language foobar does not exist.')
      end
    end
  end
end
