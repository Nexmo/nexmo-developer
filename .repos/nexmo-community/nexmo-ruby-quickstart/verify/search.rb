require 'dotenv'
Dotenv.load

API_KEY = ENV['API_KEY']
API_SECRET = ENV['API_SECRET']
VERIFY_REQUEST_ID = ENV['VERIFY_REQUEST_ID']

require 'nexmo'

client = Nexmo::Client.new(
  key: API_KEY,
  secret: API_SECRET
)

response = client.get_verification_request(VERIFY_REQUEST_ID)

if !response['error_text']
  #  the current status for
  # this request, for example:
  # => IN PROGRESS
  puts response['status']
else
  puts response['error_text']
end
