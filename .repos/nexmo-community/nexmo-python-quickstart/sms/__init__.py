import nexmo

def send(config):
    client = nexmo.Client(key=config['API_KEY'], secret=config['API_SECRET'])
    return client.send_message({'from': config['FROM_NUMBER'], 'to': config['TO_NUMBER'], 'text': 'Hello from Nexmo!'})
