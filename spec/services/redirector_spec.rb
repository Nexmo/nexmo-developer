require 'rails_helper'

RSpec.describe Redirector do
  it 'returns a redirected path' do
    request = OpenStruct.new(path: '/sms')
    expect(Redirector.find(request)).to eq('/messaging/sms/overview')
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
      request = OpenStruct.new(path: '/foo/bar')
      expect(Redirector.find(request)).to eq('https://google.com')

      request = OpenStruct.new(path: '/baz/foo/bar')
      expect(Redirector.find(request)).to eq(false)
    end
  end

  context 'when a URL is provided and it is not in any environment file' do
    before do
      allow(ENV).to receive(:[]).with('ENVIRONMENT_REDIRECTS').and_return(<<~HEREDOC
        '^\/foo\/bar\.*?': 'https://google.com'
      HEREDOC
                                                                         )

      stub_const('ENVIRONMENT_REDIRECTS', YAML.safe_load(ENV['ENVIRONMENT_REDIRECTS'] || ''))
    end

    it 'returns a redirected search path' do
      request = OpenStruct.new(path: '/voice/voice-api/guides/outbound-call-tutorial')
      expect(Redirector.find(request)).to eq('/search?query=Outbound Call Tutorial')
    end

    it 'formats the request path into a search query' do
      request = OpenStruct.new(path: '/voice/voice-api/guides/outbound-call-tutorial')
      expect(Redirector.find(request).split('=').last).to eq('Outbound Call Tutorial')
    end
  end
end
