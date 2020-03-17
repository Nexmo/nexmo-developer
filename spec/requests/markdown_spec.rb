require 'rails_helper'

RSpec.describe 'Markdown', type: :request do
  describe '#show' do
    context 'with a namespace' do
      it 'responds 200 for product-lifecycle' do
        get '/product-lifecycle/beta'

        expect(response).to have_http_status(:ok)
      end

      it 'responds 200 for contribute' do
        get '/contribute/overview'

        expect(response).to have_http_status(:ok)
      end

      it '/contribute redirects' do
        get '/contribute'

        expect(response).to redirect_to('/contribute/overview')
      end
    end

    context 'when the file specifies a redirect' do
      it 'redirects' do
        get '/client-sdk/sdk-documentation/ios/ios'

        expect(response).to redirect_to('/sdk/stitch/ios/')
      end
    end

    context 'requesting a document in a language it is not available' do
      it 'sets the canonical url to the default locale' do
        allow(File).to receive(:read).and_call_original
        expect(Nexmo::Markdown::DocFinder).to receive(:find).and_raise(Nexmo::Markdown::DocFinder::MissingDoc)
        expect(Nexmo::Markdown::DocFinder).to receive(:find).and_return(Nexmo::Markdown::DocFinder::Doc.new(path: 'path/to/doc', available_languages: ['en']))
        expect(File).to receive(:read).with('path/to/doc').and_return('markdown content')
        allow(Nexmo::Markdown::DocFinder).to receive(:find).and_call_original

        get '/cn/messages/overview'

        expect(response).to have_http_status(:ok)
        res = Capybara::Node::Simple.new(response.body)
        link = res.find("link[rel='canonical']", visible: false)
        expect(link[:href]).to eq("http://#{request.host}/messages/overview")
      end
    end

    context 'requesting a document in a language that is available and different from the default one' do
      it 'sets the canonical url to the default locale' do
        allow(File).to receive(:read).and_call_original
        expect(Nexmo::Markdown::DocFinder).to receive(:find).and_raise(Nexmo::Markdown::DocFinder::MissingDoc)
        expect(Nexmo::Markdown::DocFinder).to receive(:find).and_return(Nexmo::Markdown::DocFinder::Doc.new(path: 'path/to/doc', available_languages: ['cn', 'en']))
        expect(File).to receive(:read).with('path/to/doc').and_return('markdown content')
        allow(Nexmo::Markdown::DocFinder).to receive(:find).and_call_original

        get '/cn/messages/overview'

        expect(response).to have_http_status(:ok)
        res = Capybara::Node::Simple.new(response.body)
        link = res.find("link[rel='canonical']", visible: false)
        expect(link[:href]).to eq("http://#{request.host}/cn/messages/overview")
      end
    end

    context 'requesting a document in the default locale' do
      it 'redirects to the canonical version' do
        get '/en/messaging/sms/overview'

        expect(response).to redirect_to('/messaging/sms/overview')
      end
    end
  end

  describe '#api' do
    context 'with an existing redirect' do
      it 'redirects' do
        get '/messages/api-reference'

        expect(response).to redirect_to('/api/messages-olympus')
      end
    end

    context 'without one' do
      it 'renders 404' do
        get '/non_existing/api-reference'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
