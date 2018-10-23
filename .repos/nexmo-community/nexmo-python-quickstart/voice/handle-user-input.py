#!/usr/bin/env python3
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)


@app.route("/webhooks/answer")
def answer_call():
    for param_key, param_value in request.args.items():
        print("{}: {}".format(param_key, param_value))
    input_webhook_url = request.url_root + "webhooks/dtmf"
    ncco =[
        {
            "action": "talk",
            "text": "Hello, please press any key to continue."
        },
        {
            "action": "input",
            "maxDigits": 1,
            "eventUrl": [input_webhook_url]
        }
    ]
    return jsonify(ncco)



@app.route("/webhooks/dtmf", methods=['POST'])
def dtmf():
    data = request.get_json()
    pprint(data)
    ncco =[
        {
            "action": "talk",
            "text": "You pressed {}, goodbye".format(data['dtmf'])
        }
    ]
    return jsonify(ncco)


if __name__ == '__main__':
    app.run(port=3000)
