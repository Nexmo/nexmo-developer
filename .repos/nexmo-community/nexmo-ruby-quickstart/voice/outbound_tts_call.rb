require 'dotenv'

Dotenv.load

NEXMO_API_KEY = ENV['NEXMO_API_KEY']
NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']
NEXMO_APPLICATION_ID = ENV['NEXMO_APPLICATION_ID']
NEXMO_APPLICATION_PRIVATE_KEY_PATH = ENV['NEXMO_APPLICATION_PRIVATE_KEY_PATH']
NEXMO_NUMBER = ENV['NEXMO_NUMBER']
RECIPIENT_NUMBER = ENV['RECIPIENT_NUMBER']

require 'nexmo'

client = Nexmo::Client.new(
  api_key: NEXMO_API_KEY,
  api_secret: NEXMO_API_SECRET,
  application_id: NEXMO_APPLICATION_ID,
  private_key: File.read(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
)

response = client.calls.create(
  to: [{
    type: 'phone',
    number: RECIPIENT_NUMBER
  }],
  from: {
    type: 'phone',
    number: NEXMO_NUMBER
  },
  answer_url: [
    'https://developer.nexmo.com/ncco/tts.json'
  ]
)

puts response.inspect