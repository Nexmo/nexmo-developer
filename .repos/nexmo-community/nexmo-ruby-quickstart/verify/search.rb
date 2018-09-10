require 'dotenv'
Dotenv.load

NEXMO_API_KEY = ENV['NEXMO_API_KEY']
NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']
VERIFY_REQUEST_ID = ENV['VERIFY_REQUEST_ID']

require 'nexmo'

client = Nexmo::Client.new(
  api_key: NEXMO_API_KEY,
  api_secret: NEXMO_API_SECRET
)

response = client.verify.search(request_id: VERIFY_REQUEST_ID)

if !response.error_text
  #  the current status for
  # this request, for example:
  # => IN PROGRESS
  puts response.status
else
  puts response.error_text
end
