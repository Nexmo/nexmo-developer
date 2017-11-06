import nexmo

client = nexmo.Client(
    key=NEXMO_API_KEY,
    secret=NEXMO_API_SECRET,
    application_id=APPLICATION_ID,
    private_key=APPLICATION_PRIVATE_KEY_PATH,
)
