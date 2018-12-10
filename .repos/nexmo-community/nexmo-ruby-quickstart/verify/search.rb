require 'dotenv'
Dotenv.load

NEXMO_API_KEY = ENV['NEXMO_API_KEY']
NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']

REQUEST_ID = ARGV[0]
if REQUEST_ID.empty?
    puts 'Please supply the `request_id'
    exit
end

require 'nexmo'

client = Nexmo::Client.new(
  api_key: NEXMO_API_KEY,
  api_secret: NEXMO_API_SECRET
)

response = client.verify.search(request_id: REQUEST_ID)

if !response.error_text
  # The current status of this request, for example:
  # => IN PROGRESS
  puts response.status
else
  puts response.error_text
end
