require 'rails_helper'

RSpec.describe Navigation do
  let(:folder) { { path: '_documentation/en/concepts' } }

  describe '#options' do
    it 'returns a hash with options based on config files and the folder given' do
      options = described_class.new(folder).options

      expect(options.keys.size).to eq(3)
      expect(options['navigation_weight']).to eq(0)
      expect(options['svg']).to eq('mind-map')
      expect(options['svgColor']).to eq('red')
    end
  end

  describe '#path_to_url' do
    it 'strips the root and language from the path' do
      expect(described_class.new(folder).path_to_url).to eq('concepts')
    end
  end
end
