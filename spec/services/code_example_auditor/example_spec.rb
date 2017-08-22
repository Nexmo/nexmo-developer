require 'rails_helper'

RSpec.describe CodeExampleAuditor::Example do
  context 'full example' do
    before do
      @example = CodeExampleAuditor::Example.new({
        'source' => 'spec/fixtures/code_example_auditor/_examples/full'
      })
    end

    describe '#languages' do
      it 'has 8' do
        expect(@example.languages.count).to eq(8)
        expect(@example.languages).to include('ruby')
      end
    end

    describe '#missing_languages' do
      it 'has none' do
        puts @example.missing_languages
        expect(@example.missing_languages.count).to eq(0)
      end
    end
  end
end
