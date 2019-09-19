require 'rails_helper'

RSpec.describe 'SMS API docs', type: :request do
  context 'external-accounts' do
    it 'renders successfully' do
      get '/api/external-accounts'
      expect(response).to have_http_status(:success)
    end
  end

  context 'subscription' do
    it 'renders successfully' do
      get '/api/sms/us-short-codes/alerts/subscription'
      expect(response).to have_http_status(:success)
    end
  end

  context 'sending' do
    it 'renders successfully' do
      get '/api/sms/us-short-codes/alerts/sending'
      expect(response).to have_http_status(:success)
    end
  end

  context '2fa' do
    it 'renders successfully' do
      get '/api/sms/us-short-codes/2fa'
      expect(response).to have_http_status(:success)
    end
  end
end
