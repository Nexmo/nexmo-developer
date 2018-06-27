#!/usr/bin/env python3
# `eventMethod` is a required workaround currently, otherwise `/webhooks/recordings` is never called.
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)

@app.route("/webhooks/answer")
def answer_call():
    ncco = [
        {
            "action": "conversation",
            "name": "CONF_NAME",
            "record": "true",
            "eventMethod": "POST",
            "eventUrl": ["https://demo.ngrok.io/webhooks/recordings"]
        }
    ]
    return jsonify(ncco)

@app.route("/webhooks/recordings", methods=['POST'])
def recordings():
    data = request.get_json()
    pprint(data)
    return "Webhook received"

if __name__ == '__main__':
    app.run(port=3000)
