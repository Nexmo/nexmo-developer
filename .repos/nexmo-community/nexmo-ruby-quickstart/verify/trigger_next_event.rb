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

response = client.trigger_next_verification_event(VERIFY_REQUEST_ID)

if response['status'] == '0'
  # triggering next event
  # was a success
else
  puts response['error_text']
end
