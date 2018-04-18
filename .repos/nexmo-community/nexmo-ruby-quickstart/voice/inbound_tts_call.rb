require 'sinatra'
require 'json'

before do
  content_type :json
end

get '/webhooks/answer' do
  from = params['from']
  from_split_into_characters = from.split('').join(' ')

  [{
    action: 'talk',
    text: "Thank you for calling from #{from_split_into_characters}"
  }].to_json
end

set :port, 3000
