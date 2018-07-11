import nexmo

client = nexmo.Client(
    application_id=APPLICATION_ID,
    private_key=APPLICATION_PRIVATE_KEY_PATH,
)

client.send_dtmf(NEXMO_CALL_UUID, digits='1234')
