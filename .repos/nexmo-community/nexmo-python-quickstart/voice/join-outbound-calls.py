#!/usr/bin/env python3
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/webhooks/answer")
def answer_call():
    ncco = [
        {
            "action": "connect",
            "from": "NEXMO_NUMBER",
            "endpoint": [{
                "type": 'phone',
                "number": "RECIPIENT_NUMBER_1"
            }]
        },
        {
            "action": "connect",
            "from": "NEXMO_NUMBER",
            "endpoint": [{
                "type": 'phone',
                "number": "RECIPIENT_NUMBER_2"
            }]
        }        
    ]
    return jsonify(ncco)

if __name__ == '__main__':
    app.run(port=3000)
