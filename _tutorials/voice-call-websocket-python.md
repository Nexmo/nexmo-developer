---
title: Call a Websocket
products: voice/voice-api
description: In this tutorial, you will learn how to connect a call to a websocket endpoint that echoes the call audio back to the caller.
languages:
    - Python
---

# Call a Websocket

You can use the Nexmo Voice API to connect a call to a [WebSocket](/voice/voice-api/guides/websockets), giving you a two-way stream of the call audio delivered over the WebSocket protocol in realtime. This enables you to process the call audio to perform tasks such as sentiment analysis, real-time transcription and decision-making using artifical intelligence.

In this tutorial, you will connect an inbound call to a WebSocket endpoint. The WebSocket server will listen to the call audio and echo it back to you. You will implement this using the [Flask](http://flask.pocoo.org/) web application micro-framework and [Flask-Sockets](https://www.npmjs.com/package/express-ws), which lets you define WebSocket endpoints like any other Flask route. 

## Prerequisites

To complete this tutorial, you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up) - for your API key and secret
* [ngrok](https://ngrok.com/) - to make your development web server accessible to Nexmo's servers over the Internet
* [Node.js](https://nodejs.org/en/download/) - so that you can install the Nexmo CLI using the `npm` package installer

## Install the Nexmo CLI

You'll need a Nexmo virtual number to receive inbound calls. If you don't already have one, you can either purchase and configure numbers in the [developer dashboard](https://dashboard.nexmo.com) or use the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli). This tutorial uses the CLI.

Run the following Node Package Manager (`npm`)  command at a terminal prompt to install the CLI and configure it with your API key and secret, which you will find in the [developer dashboard](https://dashboard.nexmo.com):

```sh
npm install -g nexmo-cli
nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```

## Purchase a Nexmo number

If you don't already have one, buy a Nexmo virtual number to receive inbound calls.

First, list the numbers available in your country (replace `GB` with your two-character [country code](https://www.iban.com/country-codes)):

```sh
nexmo number:search GB
```

Purchase one of the available numbers. For example, to purchase the number `447700900001`, execute the following command:

```sh
nexmo number:buy 447700900001
```

## Create a Voice API application

Use the CLI to create a Voice API application with the webhooks that will be responsible for answering a call on your Nexmo number (`/webhooks/answer`) and logging call events (`/webhooks/events`), respectively.

These webhooks need to be accessible by Nexmo's servers, so in this tutorial you will use `ngrok` to expose your local development environment to the public Internet. [This blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) explains how to install and run `ngrok`.

Run `ngrok` using the following command:

```sh
ngrok http 3000
```

Make a note of the temporary host name that `ngrok` provides and use it in place of `example.com` in the following command:

```sh
nexmo app:create "My Echo Server" https://example.com/webhooks/answer https://example.com/webhooks/events
```

The command returns an application ID (which you should make a note of) and your public key information (which you can safely ignore for the purposes of this tutorial).

## Link your number

You need to link your Nexmo number to the Voice API application that you just created. Use the following command:

```sh
nexmo link:app NEXMO_NUMBER NEXMO_APPLICATION_ID
```

You're now ready to write your application code.

## Create the project
Make a directory for your application, `cd` into the directory and then create a file called `server.py` to contain your application code.

Then, install the [Flask](http://flask.pocoo.org/), [Flask-Sockets](https://www.npmjs.com/package/express-ws) and [gevent](https://pypi.org/project/gevent/) (a networking library that `Flask-Sockets` depends on) modules:

```sh
$ pip3 install Flask gevent Flask-Sockets
```

## Write your answer webhook

When Nexmo receives an inbound call on your virtual number, it will make a request to your `/webhooks/answer` route. This route should accept an HTTP `GET` request and return a [Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference) that tells Nexmo how to handle the call.

Your NCCO should use the `text` action to greet the caller, and the `connect` action to connect the call to your webhook endpoint:

```python
#!/usr/bin/env python3
from flask import Flask, request, jsonify
from flask_sockets import Sockets

app = Flask(__name__)
sockets = Sockets(app)


@app.route("/ncco")
def answer_call():
    ncco = [
        {
            "action": "talk",
            "text": "Please wait while we connect you to the echo server",
        },
        {
            "action": "connect",
            "from": "NexmoTest",
            "endpoint": [
                {
                    "type": "websocket",
                    "uri": "wss://{0}/socket".format(request.host),
                    "content-type": "audio/l16;rate=16000",
                }
            ],
        },
    ]

    return jsonify(ncco)
```

The `type` of `endpoint` is `websocket`, the `uri` is the `/socket` route where your WebSocket server will be accessible and the `content-type` specifies the audio quality.

## Write your event webhook

Stub out a webhook that Nexmo's servers can call to update you about call events. We won't use the request data in this tutorial, so just return an `HTTP 200` response (`success`):

```python
@app.route("/webhooks/event", methods=["POST"])
def events():
    return "200"
```

Nexmo makes a `POST` request to this endpoint every time the call status changes.

## Create the WebSocket

Create a route handler for the `/socket` route. This listens for a `message` event which is raised every time the WebSocket receives audio from the call. Your application should respond by echoing the audio back to the caller with the `send()` method:

```javascript
@sockets.route("/socket", methods=["GET"])
def echo_socket(ws):
    while not ws.closed:
        message = ws.receive()
        ws.send(message)
```

## Create your server

Finally, write the code to instantiate the server:

```python
if __name__ == "__main__":
    from gevent import pywsgi
    from geventwebsocket.handler import WebSocketHandler

    server = pywsgi.WSGIServer(("", 3000), app, handler_class=WebSocketHandler)
    server.serve_forever()
```

## Test your application

1. Run your Python application by executing the following command:

  ```sh
  python3 server.py
  ```

2. Call your Nexmo number and listen to the welcome message.

3. Say something and hear your voice echoed back to you by the other participant in the call: your WebSocket server.

## Conclusion

In this tutorial, you created an application that uses the Voice API to connect to a WebSocket endpoint.

The WebSocket you created was extremely simple, but it was able to listen to the call audio and respond to it. This is extremely powerful and can empower some very sophisticated use cases, such as artifical intelligence, analysis and transcription of call audio.

## Further reading

The following resources will help you learn more about using WebSockets in your Voice API applications:

* The [source code](https://github.com/Nexmo/python-websocket-echo-server) for this tutorial on GitHub
* The [WebSockets guide](/voice/voice-api/guides/websockets)
* The [WebSocket protocol standard](https://tools.ietf.org/html/rfc6455)
* The [Getting Started with Nexmo Voice and WebSockets recorded webinar](https://www.nexmo.com/blog/2017/02/15/webinar-getting-started-nexmo-voice-websockets-dr/)
* [Articles about WebSockets](https://www.nexmo.com/?s=websockets) on the Nexmo Developer Blog
* The [NCCO connect action](/voice/voice-api/ncco-reference#connect)
* The [Endpoints guide](/voice/voice-api/guides/endpoints)
* The [Voice API reference documentation](/voice/voice-api/api-reference)