import nexmo


client = nexmo.Client(
    application_id=APPLICATION_ID,
    private_key=APPLICATION_PRIVATE_KEY_PATH,
)

client.send_speech(NEXMO_CALL_UUID, text='Hello from Nexmo')
