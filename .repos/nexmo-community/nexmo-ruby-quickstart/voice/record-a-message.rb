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
            "action": "talk",
            "text": "Please leave a message after the tone, then press #. We will get back to you as soon as we can"
        },
        {
            "action": "record",
            "eventUrl": ["#{request.base_url}/webhooks/recordings"],
            "endOnSilence": "3",
            "endOnKey": "#",
            "beepStart": "true"
        },
        {
            "action": "talk",
            "text": "Thank you for your message. Goodbye"
        }
      ].to_json
end

route :get, :post, '/webhooks/recordings' do
  recording_url = params['recording_url'] || parsed_body['recording_url']
  puts "Recording URL = #{recording_url}"

  halt 204
end

set :port, 3000
