import os
import nexmo

def call(config):
    API_KEY = config['API_KEY']
    API_SECRET = config['API_SECRET']
    APPLICATION_ID = config['APPLICATION_ID']
    PRIVATE_KEY = open(config['PRIVATE_KEY'], 'r').read()
    TO_NUMBER = config['TO_NUMBER']
    FROM_NUMBER = config['FROM_NUMBER']
    
    client = nexmo.Client(
        key=API_KEY,
        secret=API_SECRET,
        application_id=APPLICATION_ID,
        private_key=PRIVATE_KEY
    )

    response = client.create_call({
      'to': [{'type': 'phone', 'number': TO_NUMBER}],
      'from': {'type': 'phone', 'number': FROM_NUMBER},
      'answer_url': ['https://nexmo-community.github.io/ncco-examples/first_call_talk.json']
    })

    return response
