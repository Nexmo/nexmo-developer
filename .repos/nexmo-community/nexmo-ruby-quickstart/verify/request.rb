require 'dotenv'
Dotenv.load

API_KEY = ENV['API_KEY']
API_SECRET = ENV['API_SECRET']
TO_NUMBER = ENV['TO_NUMBER']

require 'nexmo'

client = Nexmo::Client.new(
  key: API_KEY,
  secret: API_SECRET
)

response = client.start_verification(
  number: TO_NUMBER,
  brand: 'Quickstart'
)

# verification request has
# been created
if response['status'] == '0'
  # this VERIFY_REQUEST_ID can
  # be used in the next steps
  puts response['request_id']
else
  puts response['error_text']
end
