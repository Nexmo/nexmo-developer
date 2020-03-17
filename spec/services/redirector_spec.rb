require 'rails_helper'

RSpec.describe Redirector do
  it 'returns a redirected path' do
    request = OpenStruct.new(path: '/sms', params: {})
    expect(described_class.find(request)).to eq('/messaging/sms/overview')
  end

  context 'when a URL is provided in the environment' do
    before do
      allow(ENV).to receive(:[]).with('ENVIRONMENT_REDIRECTS').and_return(<<~HEREDOC
        '^\/foo\/bar\.*?': 'https://google.com'
      HEREDOC
                                                                         )

      stub_const('ENVIRONMENT_REDIRECTS', YAML.safe_load(ENV['ENVIRONMENT_REDIRECTS'] || ''))
    end

    it 'returns a redirected path' do
      request = OpenStruct.new(path: '/foo/bar', params: {})
      expect(described_class.find(request)).to eq('https://google.com')

      request = OpenStruct.new(path: '/baz/foo/bar', params: {})
      expect(described_class.find(request)).to be_falsey
    end
  end

  context '.strip_locale_from_path' do
    it 'strips the locale from path if present' do
      expect(described_class.strip_locale_from_path('/en/path')).to eq('/path')
    end

    it 'strips the locale from path if present' do
      expect(described_class.strip_locale_from_path('/path/to')).to eq('/path/to')
    end
  end
end
