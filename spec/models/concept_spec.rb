require 'rails_helper'

RSpec.describe Concept, type: :model do
  describe '#extract_product' do
    it 'extracts voice successfully' do
      allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
      expect(Concept.extract_product("#{Concept.origin}/voice/voice-api/guides/demo.md")).to eq('voice/voice-api')
    end

    it 'extracts sms successfully' do
      allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
      expect(Concept.extract_product("#{Concept.origin}/messaging/sms/guides/demo.md")).to eq('messaging/sms')
    end
  end
  describe '#all' do
    it 'returns all building blocks' do
      stub_available_concepts
      expect(Concept.all).to have(3).items
    end
  end

  describe '#by_product' do
    it 'shows only sms' do
      stub_available_concepts
      expect(Concept.by_product('messaging/sms')).to have(1).items
    end
    it 'shows only voice' do
      stub_available_concepts
      expect(Concept.by_product('voice/voice-api')).to have(2).items
    end
  end

  describe '#files' do
    it 'has the correct glob pattern' do
      allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
      expect(Dir).to receive(:glob).with('/path/to/_documentation/**/guides/**/*.md')
      Concept.files
    end
  end

  describe '#origin' do
    it 'returns the correct origin' do
      expect(Concept.origin).to eq("#{Rails.root}/_documentation")
    end
  end

  describe '.instance' do
    it 'has the expected accessors' do
      stub_available_concepts

      block = Concept.all.first
      expect(block.title).to eq('PSTN')
      expect(block.description).to eq('Introduction to PSTN')
      expect(block.navigation_weight).to eq(1)
      expect(block.product).to eq('voice/voice-api')
      expect(block.document_path).to eq('voice/voice-api/guides/pstn.md')
      expect(block.url).to eq('/voice/voice-api/guides/pstn')
    end
  end
end

def stub_available_concepts
  paths = []

  i = 0
  {
    'PSTN' => {'product' => 'voice/voice-api', 'description' => 'Introduction to PSTN'},
    'Shortcodes' => {'product' => 'messaging/sms', 'description' => 'You can use shortcodes whilst in the US'},
    'Demo' => {'product' => 'voice/voice-api', 'description' => 'Demo Topic'},
  }.each do |title, details|
    i += 1
    slug = title.parameterize
    path = "/path/to/_documentation/#{details['product']}/guides/#{slug}.md"
    paths.push(path)

    allow(File).to receive(:read).with(path) .and_return(
      {
        'title' => title,
        'description' => details['description'],
        'navigation_weight' => i,
      }.to_yaml
    )
  end

  allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
  allow(Concept).to receive(:files).and_return(paths)
end
