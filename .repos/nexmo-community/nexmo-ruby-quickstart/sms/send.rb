require 'dotenv'
Dotenv.load

NEXMO_API_KEY = ENV['NEXMO_API_KEY']
NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']
RECIPIENT_NUMBER = ENV['RECIPIENT_NUMBER']

require 'nexmo'

client = Nexmo::Client.new(
  api_key: NEXMO_API_KEY,
  api_secret: NEXMO_API_SECRET
)

client.sms.send(
  from: 'Acme Inc',
  to: RECIPIENT_NUMBER,
  text: 'A text message sent using the Nexmo SMS API'
)
