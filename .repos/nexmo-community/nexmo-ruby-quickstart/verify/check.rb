require 'dotenv'
Dotenv.load

NEXMO_API_KEY = ENV['NEXMO_API_KEY']
NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']

REQUEST_ID = ARGV[0]
if REQUEST_ID.empty?
    puts 'Please supply the `request_id'
    exit
end

CODE = ARGV[1]
if CODE.empty?    
    puts 'Please supply the confirmation code'
    exit
end

require 'nexmo'

client = Nexmo::Client.new(
  api_key: NEXMO_API_KEY,
  api_secret: NEXMO_API_SECRET
)

response = client.verify.check(
  request_id: REQUEST_ID,
  code: CODE
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
