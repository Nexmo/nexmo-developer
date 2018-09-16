#!/usr/bin/env python3
import http
from pprint import pprint

from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/webhooks/answer")
def answer_call():
    for param_key, param_value in request.args.items():
        print("{}: {}".format(param_key, param_value))
    recording_webhook_url = request.url_root + "webhooks/recording"
    ncco =[
        {
            "action": "talk",
            "text": "Please leave a message after the tone, then press the hash key."
        },
        {
            "action": "record",
            "endOnKey": "#",
            "beepStart": "true",
            "eventUrl": [recording_webhook_url]
        },
        {
            "action": "talk",
            "text": "Thank you for your message."
        }
    ])
    return jsonify(ncco)


@app.route("/webhooks/recording", methods=['POST'])
def recording_webhook():
    pprint(request.get_json())
    return ('', http.HTTPStatus.NO_CONTENT)


if __name__ == '__main__':
    app.run(port=3000)
