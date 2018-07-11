require 'dotenv'
Dotenv.load

API_KEY = ENV['API_KEY']
API_SECRET = ENV['API_SECRET']
VERIFY_REQUEST_ID = ENV['VERIFY_REQUEST_ID']
VERIFY_CODE = ENV['VERIFY_CODE']

require 'nexmo'

client = Nexmo::Client.new(
  api_key: API_KEY,
  api_secret: API_SECRET
)

response = client.verify.check(
  request_id: VERIFY_REQUEST_ID,
  code: VERIFY_CODE
)

# when the check is successful
if response.status == '0'
  # the cost of this verification
  puts response.price
  # the currency ofthe cost
  puts response.currency
else
  puts response.error_text
end
