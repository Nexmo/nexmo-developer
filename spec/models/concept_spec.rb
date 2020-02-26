require 'rails_helper'

RSpec.describe Concept, type: :model do
  describe '#extract_product' do
    it 'extracts voice successfully' do
      stub_const("#{described_class}::ORIGIN", '/path/to/_documentation')
      expect(described_class.extract_product("#{described_class::ORIGIN}/en/voice/voice-api/guides/demo.md")).to eq('voice/voice-api')
    end

    it 'extracts sms successfully' do
      stub_const("#{described_class}::ORIGIN", '/path/to/_documentation')
      expect(described_class.extract_product("#{described_class::ORIGIN}/en/messaging/sms/guides/demo.md")).to eq('messaging/sms')
    end
  end

  describe '#all' do
    it 'returns all Code Snippets' do
      stub_available_concepts
      expect(described_class.all('en')).to have(4).items
    end
  end

  describe '#by_name' do
    it 'shows a single match' do
      stub_available_concepts
      expect(described_class.by_name(['voice/voice-api/pstn-update'], 'en')).to have(1).items
    end

    it 'shows multiple matches' do
      stub_available_concepts
      expect(described_class.by_name(['voice/voice-api/pstn-update', 'messaging/sms/shortcodes'], 'en')).to have(2).items
    end
  end

  describe '#by_product' do
    it 'shows only sms' do
      stub_available_concepts
      expect(described_class.by_product('messaging/sms', 'en')).to have(1).items
    end

    it 'shows only voice' do
      stub_available_concepts
      expect(described_class.by_product('voice/voice-api', 'en')).to have(2).items
    end
  end

  describe '#files' do
    let(:language) { 'en' }

    it 'has the correct glob pattern' do
      stub_const("#{described_class}::ORIGIN", '/path/to/_documentation')
      stub_const("#{described_class}::FILES", ['guide', 'concept'])

      expect(DocFinder).to receive(:find).with(root: described_class::ORIGIN, document: 'guide', language: language).and_return('guide')
      expect(DocFinder).to receive(:find).with(root: described_class::ORIGIN, document: 'concept', language: language).and_return('concept')

      expect(described_class.files(language)).to eq(['guide', 'concept'])
    end
  end

  describe '#origin' do
    it 'returns the correct origin' do
      expect(described_class::ORIGIN).to eq('_documentation')
    end
  end

  describe '#filename' do
    it 'returns the correct filename' do
      stub_available_concepts
      expect(described_class.all('en').first.filename).to eq('pstn-update')
    end
  end

  describe '.instance' do
    it 'has the expected accessors' do
      stub_available_concepts

      block = described_class.all('en').first
      expect(block.title).to eq('PSTN Update')
      expect(block.description).to eq('Introduction to PSTN')
      expect(block.navigation_weight).to eq(1)
      expect(block.product).to eq('voice/voice-api')
      expect(block.document_path).to eq('voice/voice-api/guides/pstn-update.md')
      expect(block.url).to eq('/voice/voice-api/guides/pstn-update')
      expect(block.ignore_in_list).to eq(true)
    end
  end
end

def stub_available_concepts
  paths = []

  i = 0
  {
    'PSTN Update' => { 'product' => 'voice/voice-api', 'description' => 'Introduction to PSTN', 'ignore_in_list' => true, 'folder' => 'guides' },
    'Shortcodes' => { 'product' => 'messaging/sms', 'description' => 'You can use shortcodes whilst in the US', 'folder' => 'guides' },
    'Demo' => { 'product' => 'voice/voice-api', 'description' => 'Demo Topic', 'folder' => 'guides' },
    'New described_class' => { 'product' => 'verify/concept', 'description' => 'Demo Topic', 'folder' => 'concepts' },
  }.each do |title, details|
    i += 1
    slug = title.parameterize
    path = "/path/to/_documentation/en/#{details['product']}/#{details['folder']}/#{slug}.md"
    paths.push(path)

    allow(File).to receive(:read).with(path) .and_return(
      {
        'title' => title,
        'description' => details['description'],
        'navigation_weight' => i,
        'ignore_in_list' => details['ignore_in_list'] || false,
      }.to_yaml
    )
  end

  stub_const("#{described_class}::ORIGIN", '/path/to/_documentation')
  allow(described_class).to receive(:files).and_return(paths)
end
