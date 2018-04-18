#!/usr/bin/env python3

from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/webhooks/answer")
def answer_call():
    for param_key, param_value in request.args.items():
        print("{}: {}".format(param_key, param_value))

    from_ = request.args['from']

    return jsonify([
        {
            "action": "talk",
            "text": "Thank you for calling from " + " ".join(from_)
        }
    ])


if __name__ == '__main__':
    app.run(port=3000)
