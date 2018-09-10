require 'json'
require 'dotenv'

Dotenv.load

NEXMO_APPLICATION_ID = ENV['NEXMO_APPLICATION_ID']
NEXMO_APPLICATION_PRIVATE_KEY_PATH = ENV['NEXMO_APPLICATION_PRIVATE_KEY_PATH']

require 'nexmo'

client = Nexmo::Client.new(
    application_id: NEXMO_APPLICATION_ID,
    private_key: File.read(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
)

ncco = {"type": "ncco", "url": ["https://developer.nexmo.com/ncco/transfer.json"]}

response = client.calls.transfer(UUID, destination: ncco)

puts response.inspect