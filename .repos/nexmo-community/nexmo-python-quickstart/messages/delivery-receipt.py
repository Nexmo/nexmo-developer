#!/usr/bin/env python3
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)

@app.route("/webhooks/delivery-receipt", methods=['POST'])
def delivery_receipt():
    data = request.get_json()
    pprint(data)
    return "200"

if __name__ == '__main__':
    app.run(host="www.example.org", port=3000)
