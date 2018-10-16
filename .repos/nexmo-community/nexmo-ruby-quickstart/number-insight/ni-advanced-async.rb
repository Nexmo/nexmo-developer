require 'sinatra'
require 'sinatra/multi_route'
require 'json'

helpers do
  def parsed_body
     json? ? JSON.parse(request.body.read) : {}
  end

  def json?
    request.content_type == 'application/json'
  end
end

route :post, '/webhooks/insight' do
  puts params.merge(parsed_body)
  
  status 200
end

set :port, 3000
