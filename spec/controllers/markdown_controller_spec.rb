require 'rails_helper'

RSpec.describe MarkdownController, type: :controller do
  it 'renders' do
    get :show, params: { product: 'messaging/sms', document: 'overview' }

    expect(response.status).to eq(200)
  end

  context 'having a preferred language set' do
    it 'redirects to the language stored in the session' do
      get :show, params: { product: 'messaging/sms', document: 'overview' }, session: { locale: 'cn' }

      expect(response).to redirect_to('/cn/messaging/sms/overview')
    end

    it 'renders' do
      get :show, params: { product: 'messaging/sms', document: 'overview', locale: 'cn' }, session: { locale: 'cn' }

      expect(response.status).to eq(200)
    end

    it 'renders' do
      get :show, params: { product: 'messaging/sms', document: 'overview' }, session: { locale: 'en' }

      expect(response.status).to eq(200)
    end

    it 'renders' do
      get :show, params: { product: 'messaging/sms', document: 'overview', locale: 'cn' }, session: { locale: 'en' }

      expect(response.status).to eq(200)
    end
  end
end
