require 'sinatra'
require 'sinatra/multi_route'
require 'json'

before do
  content_type :json
end

route :get, :post, '/webhooks/answer' do
  [{
    action: 'connect',
    endpoint: [{
      type: 'phone',
      number: YOUR_SECOND_NUMBER
    }]
  }].to_json
end

set :port, 3000
