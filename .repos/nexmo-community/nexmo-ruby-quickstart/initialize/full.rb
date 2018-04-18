require 'nexmo'

client = Nexmo::Client.new(
  key: NEXMO_API_KEY,
  secret: NEXMO_API_SECRET,
  application_id: NEXMO_APPLICATION_ID,
  private_key: File.read(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
)
