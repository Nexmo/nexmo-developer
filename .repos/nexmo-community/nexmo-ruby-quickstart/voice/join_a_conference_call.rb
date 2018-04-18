require 'sinatra'
require 'json'

before do
  content_type :json
end

get '/webhooks/answer' do
  [
    {
      action: 'talk',
      text: 'Welcome to a Nexmo powered conference call'
    },
    {
      action: 'conversation',
      name: 'room-name'
    }
  ].to_json
end

set :port, 3000
