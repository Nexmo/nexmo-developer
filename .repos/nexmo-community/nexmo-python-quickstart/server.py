from flask import Flask, jsonify
app = Flask(__name__)
app.config.from_pyfile('.env')

import sms
import voice

@app.route("/sms/send")
def sms_send():
    return jsonify(sms.send(app.config))

@app.route("/voice/call")
def call():
    return jsonify(voice.call(app.config))

if __name__ == "__main__":
    app.run()
