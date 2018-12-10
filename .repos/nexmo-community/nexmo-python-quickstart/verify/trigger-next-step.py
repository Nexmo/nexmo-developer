import argparse
import os
from os.path import join, dirname
from dotenv import load_dotenv

dotenv_path = join(dirname(__file__), "../.env")
load_dotenv(dotenv_path)

NEXMO_API_KEY = os.getenv("NEXMO_API_KEY")
NEXMO_API_SECRET = os.getenv("NEXMO_API_SECRET")

argument_parser = argparse.ArgumentParser()
argument_parser.add_argument("request_id")
arguments = argument_parser.parse_args()

REQUEST_ID = arguments.request_id

import nexmo

client = nexmo.Client(key=NEXMO_API_KEY, secret=NEXMO_API_SECRET)

response = client.trigger_next_verification_event(REQUEST_ID)

if response["status"] == "0":
    print("Next verification stage triggered")
else:
    print("Error: %s" % response["error_text"])
