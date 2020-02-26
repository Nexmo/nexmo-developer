require 'rails_helper'

RSpec.describe Search::Document do
  let(:doc_type) { 'documentation' }
  let(:path) { '_documentation/en/concepts/overview.md' }
  let(:config) do
    {
      documents: [path],
      origin: Pathname.new('_documentation/en'),
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

  subject { described_class.new(doc_type, config, path) }

  before do
    allow(File).to receive(:read).with(Pathname.new(path)).and_return(file_content)
  end

  describe '#title' do
    it 'returns the title defined in the frontmatter' do
      expect(subject.title).to eq('Overview')
    end
  end

  describe '#description' do
    it 'returns the description defined in the frontmatter' do
      expect(subject.description).to eq('Dummy description')
    end
  end

  describe '#body' do
    it 'parses the body as html' do
      expect(MarkdownPipeline).to receive_message_chain(:new, :call)

      subject.body
    end
  end

  describe '#articles' do
    it 'creates an Article for each section of the doc' do
      expect(subject.articles).to be_an_instance_of(Array)
      expect(subject.articles.first).to be_an_instance_of(Search::Article)
    end
  end
end
