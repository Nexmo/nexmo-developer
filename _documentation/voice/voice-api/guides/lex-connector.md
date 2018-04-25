---
title: Amazon Lex Connector
navigation_weight: 8

---

# Connecting voice calls to Amazon Lex bots

## Overview

You can use the Lex Connector to connect a Nexmo voice call to an [AWS Lex](https://aws.amazon.com/lex/) bot and then have an audio conversation with the bot.

Lex Connector makes use of the [WebSockets feature](/concepts/guides/websockets) of Nexmo's Voice API. When a call is established, the API makes a websocket connection to Lex Connector and streams the audio to and from the call in real time.

Lex Connector then takes care of capturing chunks of speech using Voice Activity Detection to then post to the Lex Endpoint. When Lex returns audio, Lex Connector streams that back over the websocket to the call.

Lex Connector does not store any Lex-specific configuration or credentials: these are supplied in the NCCO, telling the Voice API to connect the call to the Connector. This is a standard `connect` function used to connect calls to WebSockets, with a few specific parameters to connect to Lex.

## Pre-requisites

Before you begin:

* Sign up for a [Nexmo account](https://dashboard.nexmo.com/signup)
* Buy a virtual number (through the Dashboard or [Nexmo CLI](https://github.com/nexmo/nexmo-cli))
* Create a Lex bot on AWS
* Ensure you have an AWS key and secret that has access to the Lex bot


## Connecting a call to Lex 

When a call is made to your number, Nexmo handles the call according to the rules laid out in an NCCO. See [Accept inbound calls](/voice/guides/inbound-calls) for details on how this is done.

Here is an example of the NCCO you should return to handle incoming calls with LexConnector:

```json
[
    {
        "action": "talk",
        "text": "Hello, I am Lex, how can I help you?"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "content-type": "audio/l16;rate=16000",
                "headers": {
                    "aws_key": "AAAAAAAAAAAAAAAAAAAAAAAAAAA",
                    "aws_secret": "eescOz9xisx+gx-PFU3G4AJg4NE4UExnHYaijI+o6xgNT0"
                },
                "type": "websocket",
                "uri": "wss://lex-us-east-1.nexmo.com/bot/BOTNAME/alias/ALIAS/user/USER/content"
            }
        ],
        "eventUrl": [
            "http://example.com/event"
        ]
    }
]
```

The first `talk` action is a simple way to start the call: Lex expects the user to speak first, so we need to start the conversation as one would in a phone call, with the answerer greeting the caller. You can customise this text to fit your use case.

You should look at the [range of voices available on Nexmo](/voice/guides/ncco-reference#talk) and on Lex to select the same voice, so that it feels natural for the caller. (There is some overlap in the choice of voices available from both Nexmo and Lex.)

The next action is `connect`: this makes call connect to the WebSocket endpoint, specifically the Lex Connector WebSocket.

The path portion of the uri is the same as the path to the [`PostContent`](http://docs.aws.amazon.com/lex/latest/dg/API_PostContent.html) endpoint within Lex but with `lex-us-east-1.nexmo.com` as host instead of AWS. You should set your BOTNAME, ALIAS and USER details as part of this URI. You can get these details from the AWS Console.

Within the headers section of the endpoint you must supply the `aws_key` and `aws_secret` that will be used to connect to Lex.

The `eventUrl` is where Nexmo will send events regarding the connection to the Lex Connector so that your application can be aware of the start and end of a session. Currently we do not share any data or events on the requests to and from Lex: the only events sent are the start and end of the call.

The `content-type` is a fixed value.

## Test it out

Point your Nexmo number to your NCCO (it can be hosted statically—on S3, for instance—or served dynamically) using either [Nexmo CLI](https://github.com/nexmo/nexmo-cli) or the [Dashboard](https://dashboard.nexmo.com)
