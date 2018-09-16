import os
from os.path import join, dirname
from dotenv import load_dotenv

dotenv_path = join(dirname(__file__), '../.env')
load_dotenv(dotenv_path)

NEXMO_API_KEY = os.getenv('NEXMO_API_KEY')
NEXMO_API_SECRET = os.getenv('NEXMO_API_SECRET')
TO_NUMBER = os.getenv('TO_NUMBER')

import nexmo

client = nexmo.Client(key=NEXMO_API_KEY, secret=NEXMO_API_SECRET)

client.send_message({
    'from': 'Acme Inc',
    'to': TO_NUMBER,
    'text': 'こんにちは世界',
    'type': 'unicode',
})
