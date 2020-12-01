require 'spec_helper'

RSpec.describe 'Visiting /store', type: :request do
  let(:app) { Rack::Builder.new.run Rails.application }

  it 'redirects to apimanager.uc.vonage.com' do
    get '/store'

    expect(last_response.status).to eq(302)
    expect(last_response.headers['Location']).to eq('https://apimanager.uc.vonage.com/store/')
  end
end
