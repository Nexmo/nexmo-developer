require 'rails_helper'

RSpec.describe Career do
  let(:url) { 'https://boards.greenhouse.io/vonage/jobs/123' }
  let(:content) do
    '&lt;p&gt;&lt;span style=&quot;font-weight: 400;&quot;&gt;As a Developer Advocate at Nexmo...&lt;/span&gt;&lt;/p&gt;'
  end
  let(:greenhouse_career) do
    {
      title: 'Developer Advocate',
      location: { name: 'Remote - EU' },
      content: content,
      absolute_url: url,
    }
  end

  subject { described_class.new(greenhouse_career) }

  describe '#title' do
    it { expect(subject.title).to eq('Developer Advocate') }
  end

  describe '#location' do
    it { expect(subject.location).to eq('Remote - EU') }
  end

  describe '#description' do
    it 'parses the response as html' do
      expect(subject.description).to eq(
        '<p><span style="font-weight: 400;">As a Developer Advocate at Nexmo...</span></p>'
      )
    end

    %w[h1 h2 h3 h4 h5 h6].each do |tag|
      it "removes the first child element if it is a #{tag}" do
        career = described_class.new({
                                       content: "<#{tag}>Some Title</#{tag}><p>As a Developer Advocate at Nexmo...</p>",
                                     })
        expect(career.description).to eq(
          '<p>As a Developer Advocate at Nexmo...</p>'
        )
      end
    end
  end

  describe '#url' do
    it { expect(subject.url).to eq(url) }
  end
end
