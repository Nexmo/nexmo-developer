require 'dotenv'
Dotenv.load

NEXMO_API_KEY = ENV['NEXMO_API_KEY']
NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']
TO_NUMBER = ENV['TO_NUMBER']

require 'nexmo'

client = Nexmo::Client.new(
  key: NEXMO_API_KEY,
  secret: NEXMO_API_SECRET
)

client.send_message(
  from: 'Acme Inc',
  to: TO_NUMBER,
  text: 'A text message sent using the Nexmo SMS API'
)
