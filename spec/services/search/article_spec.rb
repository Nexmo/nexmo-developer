require 'rails_helper'

RSpec.describe Search::Article do
  let(:doc_type) { 'documentation' }
  let(:path) { '_documentation/cn/concepts/overview.md' }
  let(:config) do
    {
      documents: [path],
      origin: Pathname.new('_documentation/cn'),
      base_url_path: '',
    }
  end
  let(:file_content) do
    <<~HEREDOC
      ---
      title: Overview
      description: Dummy description
      meta_title: Understanding core Nexmo concepts
      ---

      # Concepts

      There are a number of shared concepts between the Nexmo APIs...
    HEREDOC
  end
  let(:doc) { Search::Document.new(doc_type, config, path) }

  let(:html) { Nokogiri::HTML(doc.body) }

  subject { described_class.new(doc, html) }

  before do
    allow(File).to receive(:read).with(Pathname.new(path)).and_return(file_content)
  end

  describe '#to_h' do
    it 'returns a hash representation of the object' do
      hash = subject.to_h

      expect(hash[:title]).to eq('Overview')
      expect(hash[:heading]).to eq('Concepts')
      expect(hash[:anchor]).to eq('concepts')
      expect(hash[:description]).to eq('Dummy description')
      expect(hash[:document_class]).to eq('documentation')
      expect(hash[:path]).to eq('/concepts/overview')
      expect(hash[:document_path]).to eq(Pathname.new(path))
      expect(hash[:body]).to eq(html.text)
      expect(hash[:product]).to eq('concepts')
    end
  end
end
