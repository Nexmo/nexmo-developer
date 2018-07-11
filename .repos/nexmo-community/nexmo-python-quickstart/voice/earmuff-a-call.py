#!/usr/bin/env python3
import nexmo
import time
from pprint import pprint

client = nexmo.Client(
    application_id=APPLICATION_ID,
    private_key=APPLICATION_PRIVATE_KEY_PATH,
)

response = client.update_call(UUID, action="earmuff")
pprint(response)
time.sleep(5)
response = client.update_call(UUID, action="unearmuff")
pprint(response)
