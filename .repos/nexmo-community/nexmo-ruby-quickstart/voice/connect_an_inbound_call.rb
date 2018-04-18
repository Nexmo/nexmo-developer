require 'sinatra'
require 'json'

before do
  content_type :json
end

get '/webhooks/answer' do
  [{
    action: 'connect',
    endpoint: [{
      type: 'phone',
      number: YOUR_SECOND_NUMBER
    }]
  }].to_json
end

set :port, 3000
