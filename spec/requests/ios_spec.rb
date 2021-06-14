require 'spec_helper'

RSpec.describe 'iOS docs', type: :request do
  let(:app) { Rack::Builder.new.run Rails.application }

  context 'SDK reference' do
    it 'redirects to the proper path' do
      get '/client-sdk/sdk-documentation/ios/ios'

      expect(last_response).to be_redirect
      expect(last_response.headers['Location']).to eq('http://example.org/sdk/stitch/ios/latest/index')
    end

    it 'renders successsfully' do
      get '/sdk/stitch/ios/latest/index'

      expect(last_response.status).to be(200)
    end
  end

  context 'Release Notes' do
    it 'renders successsfully' do
      get '/client-sdk/sdk-documentation/ios/release-notes'

      expect(last_response.status).to be(200)
    end
  end
end
