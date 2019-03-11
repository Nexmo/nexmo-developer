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

  describe '.languages' do
    let(:languages) { CodeLanguage.languages }

    it 'returns an array of code languages' do
      expect(languages).to be_kind_of(Array)
      expect(languages[0]).to be_kind_of(CodeLanguage)
      expect(languages[0].type).to eq('languages')
    end
  end

  describe '.frameworks' do
    let(:languages) { CodeLanguage.frameworks }

    it 'returns an array of code languages' do
      expect(languages).to be_kind_of(Array)
      expect(languages[0]).to be_kind_of(CodeLanguage)
      expect(languages[0].type).to eq('platforms')
    end
  end

  describe '.terminal_programs' do
    let(:languages) { CodeLanguage.terminal_programs }

    it 'returns an array of code languages' do
      expect(languages).to be_kind_of(Array)
      expect(languages[0]).to be_kind_of(CodeLanguage)
      expect(languages[0].type).to eq('terminal_programs')
    end
  end

  describe '.data' do
    let(:languages) { CodeLanguage.data }

    it 'returns an array of code languages' do
      expect(languages).to be_kind_of(Array)
      expect(languages[0]).to be_kind_of(CodeLanguage)
      expect(languages[0].type).to eq('data')
    end
  end

  describe '.all' do
    let(:languages) { CodeLanguage.all }

    it 'returns an array of code languages' do
      expect(languages).to be_kind_of(Array)
      expect(languages[0]).to be_kind_of(CodeLanguage)
    end
  end

  describe '.find' do
    it 'returns the code language for the given key' do
      expect(CodeLanguage.find('ruby')).to be_kind_of(CodeLanguage)
      expect(CodeLanguage.find('ios')).to be_kind_of(CodeLanguage)
      expect(CodeLanguage.find('curl')).to be_kind_of(CodeLanguage)
    end

    context 'when given an invalid key' do
      it 'raises an exception' do
        expect { CodeLanguage.find('foobar') }.to raise_exception('Language foobar does not exist.')
      end
    end
  end

  describe '.linkable' do
    let(:languages) { CodeLanguage.linkable }

    it 'returns an array of code languages' do
      expect(languages).to be_kind_of(Array)
      expect(languages[0]).to be_kind_of(CodeLanguage)
    end

    it 'excludes code languages that are not linkable' do
      expect(languages.map(&:key)).not_to include('cli')
      expect(languages.map(&:key)).not_to include('json')
      expect(languages.all?(&:linkable?)).to eq(true)
    end
  end

  describe '.route_constraint' do
    let(:route_constraint) { CodeLanguage.route_constraint }

    it 'returns a route constraint hash' do
      expect(route_constraint).to be_a(Hash)
      expect(route_constraint[:code_language]).to be_a(Regexp)
    end
  end
end
