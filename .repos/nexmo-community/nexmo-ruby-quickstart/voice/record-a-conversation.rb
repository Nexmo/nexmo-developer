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

CONF_NAME = "record-a-conversation"

route :get, :post, '/webhooks/answer' do
    [
        {
          action: "conversation",
          name: CONF_NAME,
          record: "true",
          #This currently needs to be set rather than default due to a known issue https://help.nexmo.com/hc/en-us/articles/360001162687
          eventMethod: "POST", 
          eventUrl: ["#{request.base_url}/webhooks/recordings"]
        }
      ].to_json
end

route :get, :post, '/webhooks/recordings' do
  recording_url = params['recording_url'] || parsed_body['recording_url']
  puts "Recording URL = #{recording_url}"

  halt 204
end

set :port, 3000
