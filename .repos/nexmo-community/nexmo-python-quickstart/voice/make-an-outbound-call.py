import os
from os.path import join, dirname
from dotenv import load_dotenv

dotenv_path = join(dirname(__file__), '../.env')
load_dotenv(dotenv_path)

APPLICATION_PRIVATE_KEY_PATH = os.getenv('APPLICATION_PRIVATE_KEY_PATH')
APPLICATION_ID = os.getenv('APPLICATION_ID')
TO_NUMBER = os.getenv('TO_NUMBER')
NEXMO_NUMBER = os.getenv('NEXMO_NUMBER')

import nexmo

client = nexmo.Client(
    application_id=APPLICATION_ID,
    private_key=APPLICATION_PRIVATE_KEY_PATH,
)

client.create_call({
  'to': [{'type': 'phone', 'number': TO_NUMBER}],
  'from': {'type': 'phone', 'number': NEXMO_NUMBER},
  'answer_url': ['https://developer.nexmo.com/ncco/tts.json']
})
