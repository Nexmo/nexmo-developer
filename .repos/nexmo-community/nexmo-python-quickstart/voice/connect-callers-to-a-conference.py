#!/usr/bin/env python3
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/webhooks/answer")
def answer_call():
    ncco = [
        {
            "action": "talk",
            "text": "Please wait while we connect you to the conference"
        },
        {
            "action": "conversation",
            "name": CONF_NAME
        }]
    return jsonify(ncco)


if __name__ == '__main__':
    app.run(port=3000)
