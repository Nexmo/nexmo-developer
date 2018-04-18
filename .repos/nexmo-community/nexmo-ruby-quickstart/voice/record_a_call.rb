require 'sinatra'
require 'json'

before do
  content_type :json
end

helpers do
  def parsed_body
    JSON.parse(request.body.read)
  end
end

get '/webhooks/answer' do
  [
    {
      action: 'talk',
      text: 'Please leave a message after the tone, then press pound.'
    },
    {
      action: 'record',
      endOnKey: '#',
      beepStart: 'true',
      eventUrl: [
        "#{request.base_url}/webhooks/recording"
      ]
    },
    {
      action: 'talk',
      text: 'Thank you for your message.'
    }
  ].to_json
end

post '/webhooks/recording' do
  recording_url = parsed_body['recording_url']
  puts "Recording URL = #{recording_url}"

  halt 204
end

set :port, 3000
