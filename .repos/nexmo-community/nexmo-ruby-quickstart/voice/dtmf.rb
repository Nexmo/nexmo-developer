require 'sinatra'
require 'json'

helpers do
  def parsed_body
    JSON.parse(request.body.read)
  end
end

before do
  content_type :json
end

get '/webhooks/answer' do
  [
    {
      action: 'talk',
      text: 'Please enter a digit'
    },
    {
      action: 'input',
      eventUrl: ["#{request.base_url}/webhooks/dtmf"]
    }
  ].to_json
end

post '/webhooks/dtmf' do
  dtmf = parsed_body['dtmf']

  [{
    action: 'talk',
    text: "You pressed #{dtmf}"
  }].to_json
end

set :port, 3000
