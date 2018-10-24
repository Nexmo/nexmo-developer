require 'rails_helper'

RSpec.describe BuildingBlock, type: :model do
  describe '#extract_product' do
    it 'extracts voice successfully' do
      allow(BuildingBlock).to receive(:origin).and_return('/path/to/_documentation')
      expect(BuildingBlock.extract_product("#{BuildingBlock.origin}/voice/voice-api/building-blocks/demo.md")).to eq('voice/voice-api')
    end

    it 'extracts sms successfully' do
      allow(BuildingBlock).to receive(:origin).and_return('/path/to/_documentation')
      expect(BuildingBlock.extract_product("#{BuildingBlock.origin}/messaging/sms/building-blocks/demo.md")).to eq('messaging/sms')
    end
  end

  describe '#extract_category' do
    it 'sets no category for top level building blocks' do
      allow(BuildingBlock).to receive(:origin).and_return('/path/to/_documentation')
      expect(BuildingBlock.extract_category("#{BuildingBlock.origin}/voice/voice-api/building-blocks/demo.md")).to eq(nil)
    end

    it 'sets the correct category for nested building blocks' do
      allow(BuildingBlock).to receive(:origin).and_return('/path/to/_documentation')
      expect(BuildingBlock.extract_category("#{BuildingBlock.origin}/messaging/sms/building-blocks/sub-folder/demo.md")).to eq('Sub folder')
    end
  end

  describe '#all' do
    it 'returns all building blocks' do
      stub_available_blocks
      expect(BuildingBlock.all).to have(4).items
    end
  end

  describe '#by_product' do
    it 'shows only sms' do
      stub_available_blocks
      expect(BuildingBlock.by_product('messaging/sms')).to have(1).items
    end
    it 'shows only voice' do
      stub_available_blocks
      expect(BuildingBlock.by_product('voice/voice-api')).to have(3).items
    end
  end

  describe '#files' do
    it 'has the correct glob pattern' do
      allow(BuildingBlock).to receive(:origin).and_return('/path/to/_documentation')
      expect(Dir).to receive(:glob).with('/path/to/_documentation/**/building-blocks/**/*.md')
      BuildingBlock.files
    end
  end

  describe '#origin' do
    it 'returns the correct origin' do
      expect(BuildingBlock.origin).to eq("#{Rails.root}/_documentation")
    end
  end

  describe '.instance' do
    it 'has the expected accessors' do
      stub_available_blocks

      block = BuildingBlock.all.first
      expect(block.title).to eq('Example Long Title')
      expect(block.navigation_weight).to eq(1)
      expect(block.product).to eq('voice/voice-api')
      expect(block.category).to eq(nil)
      expect(block.document_path).to eq('voice/voice-api/building-blocks/example-long-title.md')
      expect(block.url).to eq('/voice/voice-api/building-blocks/example-long-title')
    end
  end
end

def stub_available_blocks
  paths = []

  i = 0
  {
    'Example Long Title' => 'voice/voice-api',
    'Short' => 'messaging/sms',
    'Demo' => 'voice/voice-api',
  }.each do |title, product|
    i += 1
    slug = title.parameterize
    path = "/path/to/_documentation/#{product}/building-blocks/#{slug}.md"
    paths.push(path)

    allow(File).to receive(:read).with(path) .and_return(
      {
        'title' => title,
        'navigation_weight' => i,
      }.to_yaml
    )
  end

  # Add an example that has nested folders
  path = '/path/to/_documentation/voice/voice-api/building-blocks/nested-blocks/nested-example.md'
  i += 1
  allow(File).to receive(:read).with(path) .and_return(
    {
      'title' => 'This is a nested example',
      'navigation_weight' => i,
    }.to_yaml
  )
  paths.push(path)

  allow(BuildingBlock).to receive(:origin).and_return('/path/to/_documentation')
  allow(BuildingBlock).to receive(:files).and_return(paths)
end
