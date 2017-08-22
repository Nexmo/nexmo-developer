require 'rails_helper'

RSpec.describe CodeExampleAuditor do
  before do
    @auditor = CodeExampleAuditor.new('spec/fixtures/code_example_auditor')
  end

  describe 'self.all_languages' do
    it 'lists all languages' do
      expect(CodeExampleAuditor.all_languages.class).to eq(Array)
      expect(CodeExampleAuditor.all_languages).to include('csharp')
      expect(CodeExampleAuditor.all_languages).to include('curl')
      expect(CodeExampleAuditor.all_languages).to include('dotnet')
      expect(CodeExampleAuditor.all_languages).to include('java')
      expect(CodeExampleAuditor.all_languages).to include('node')
      expect(CodeExampleAuditor.all_languages).to include('php')
      expect(CodeExampleAuditor.all_languages).to include('python')
      expect(CodeExampleAuditor.all_languages).to include('ruby')
      expect(CodeExampleAuditor.all_languages).to_not include('xml')
      expect(CodeExampleAuditor.all_languages).to_not include('json')
      expect(CodeExampleAuditor.all_languages).to_not include('ncco')
    end
  end

  describe '#examples' do
    it 'has 4 examples' do
      expect(@auditor.examples.count).to eq(4)
      expect(@auditor.examples.map(&:documents).flatten.count).to eq(5)
    end
  end

  describe '#examples_with_manual_tabs' do
    it 'has 2 examples' do
      expect(@auditor.examples_with_manual_tabs.count).to eq(2)
    end
  end

  describe '#documents' do
    it 'has two documents' do
      expect(@auditor.documents.count).to eq(4)
    end
  end
end
