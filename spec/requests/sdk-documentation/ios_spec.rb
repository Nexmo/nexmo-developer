require 'rails_helper'

RSpec.describe 'iOS docs', type: :request do
  context 'SDK reference' do
    it 'redirects to the proper path' do
      get '/client-sdk/sdk-documentation/ios/ios'

      expect(response).to redirect_to('/sdk/stitch/ios/')
    end

    it 'renders successsfully' do
      get '/sdk/stitch/ios'

      expect(response).to have_http_status(:ok)
    end
  end

  context 'Release Notes' do
    it 'renders successsfully' do
      get '/client-sdk/sdk-documentation/ios/release-notes'

      expect(response).to have_http_status(:ok)
    end
  end
end
