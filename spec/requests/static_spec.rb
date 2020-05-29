require 'rails_helper'

RSpec.describe 'Static', type: :request do
  describe '#spotlight' do
    let(:url) { 'https://hooks.zapier.com/hooks/catch/1936493/oyzjr4i/' }
    let(:params) do
      {
        'name' => 'test',
        'email_address' => 'test@test.com',
        'background' => 'test',
        'outline' => 'test',
        'previous_content' => '',
      }
    end

    context 'makes a request to zapier' do
      it 'returns success if 200' do
        expect(RestClient).to receive(:post).with(url, params).and_return(double(RestClient::Response, code: 200))

        post '/spotlight', params: params

        expect(response).to have_http_status(:ok)
      end

      it 'returns 422 otherwise' do
        expect(RestClient).to receive(:post).with(url, params).and_return(double(RestClient::Response, code: 422))

        post '/spotlight', params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
