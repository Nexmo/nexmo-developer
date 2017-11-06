require 'sinatra'
require 'sinatra/multi_route'
require 'json'

before do
  content_type :json
end

route :get, :post, '/webhooks/answer' do
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
