require 'rails_helper'

RSpec.describe 'A/B testing', type: :request do
  let(:params) do
    {
      t: 'try_button_v2',
      ab_result: { t: 'try_button_v2' },
    }
  end

  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end

  it 'finishes an experiment' do
    use_ab_test experiment_name: 'try_button'

    post '/usage/ab_result', params: params, headers: headers

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(:ok)
  end
end
