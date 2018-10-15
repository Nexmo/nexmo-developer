require 'dotenv'

Dotenv.load

NEXMO_APPLICATION_ID = ENV['NEXMO_APPLICATION_ID']
NEXMO_APPLICATION_PRIVATE_KEY_PATH = ENV['NEXMO_APPLICATION_PRIVATE_KEY_PATH']

require 'nexmo'
require 'time'

client = Nexmo::Client.new(
    application_id: NEXMO_APPLICATION_ID,
    private_key: File.read(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
)

now = Time.now
yesterday = now - (3600 * 24)

response = client.calls.list({date_start: yesterday.utc.iso8601, date_end: now.utc.iso8601})

calls = response._embedded.calls
calls.each do |call|
    puts call.inspect
end