require 'dotenv'

Dotenv.load

NEXMO_NUMBER = ENV['NEXMO_NUMBER']
TO_NUMBER = ENV['RECIPIENT_NUMBER']

require 'sinatra'
require 'sinatra/multi_route'
require 'json'

before do
  content_type :json
end

helpers do
  def parsed_body
    JSON.parse(request.body.read)
  end
end

route :get, :post, '/webhooks/answer' do
    [
        {
          "action": "record",
          "split": "conversation",
          "eventUrl": ["#{request.base_url}/webhooks/recordings"]
        },
        {
          "action": "connect",
          "from": NEXMO_NUMBER,
          "endpoint": [
            {
              "type": "phone",
              "number": TO_NUMBER
            }
          ]
        }
      ].to_json
end

route :get, :post, '/webhooks/recordings' do
  recording_url = params['recording_url'] || parsed_body['recording_url']
  puts "Recording URL = #{recording_url}"

  halt 204
end

set :port, 3000
