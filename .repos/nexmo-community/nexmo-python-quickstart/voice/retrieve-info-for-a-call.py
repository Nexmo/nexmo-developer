#!/usr/bin/env python3
import nexmo
from pprint import pprint

client = nexmo.Client(
    application_id=APPLICATION_ID,
    private_key=APPLICATION_PRIVATE_KEY_PATH,
)

# Note call can be made to current call or a completed call
response = client.get_call("NEXMO_CALL_UUID")
pprint(response)
