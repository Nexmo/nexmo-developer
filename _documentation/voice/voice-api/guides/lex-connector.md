---
title: Amazon Lex Connector
description: You can use the Lex Connector to connect a Nexmo voice call to an [AWS Lex](https://aws.amazon.com/lex/) bot and then have an audio conversation with the bot.
navigation_weight: 8
---

# Connecting voice calls to Amazon Lex bots

## Overview

You can use the Lex Connector to connect a Nexmo voice call to an [AWS
Lex](https://aws.amazon.com/lex/) bot and then have an audio
conversation with the bot.

Lex Connector makes use of the [WebSockets
feature](/voice/voice-api/guides/websockets) of Nexmo's Voice API. When a
call is established, the API makes a websocket connection to Lex
Connector and streams the audio to and from the call in real-time.

Lex Connector then takes care of capturing chunks of speech using
Voice Activity Detection to then post to the Lex Endpoint. When Lex
returns audio, Lex Connector streams that back over the websocket to
the call.

Lex Connector does not store any Lex-specific configuration or
credentials: these are supplied in the NCCO, telling the Voice API to
connect the call to the Connector. This is a standard `connect`
function used to connect calls to WebSockets, with a few specific
parameters to connect to Lex.

## Prerequisites

Before you begin:

* Sign up for a [Nexmo account](https://dashboard.nexmo.com/signup)
* Buy a virtual number (through the Dashboard or [Nexmo CLI](https://github.com/nexmo/nexmo-cli))
* Create a Lex bot on AWS
* Ensure you have an AWS key and secret that has access to the Lex bot


## Connecting a call to Lex 

When a call is made to your number, Nexmo makes a request to the `answer_url` defined in the configuration of your application. The NCCO returned at this URL tells Nexmo how to handle the incoming call.

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

The first `talk` action is a simple way to start the call. Lex expects the user to speak first, so you need to start the conversation as you would in a phone call, by greeting the caller. You can customise this text to fit your use case.

By comparing the [range of voices available on Nexmo](/voice/voice-api/guides/text-to-speech#voice-names) with those available on Lex, you can select a combination of voices that feels natural for the caller. There is some overlap in the choice of voices available from both Nexmo and Lex.

The next action is `connect`: this makes call connect to the WebSocket endpoint, specifically the Lex Connector WebSocket.

The path portion of the URI is the same as the path to the [`PostContent`](http://docs.aws.amazon.com/lex/latest/dg/API_PostContent.html) endpoint within Lex, but with `lex-us-east-1.nexmo.com` as host instead of AWS. You should set your `BOTNAME`, `ALIAS` and `USER` details as part of this URI. You can get these details from the AWS Console.

Within the headers section of the endpoint you must supply the `aws_key` and `aws_secret` that will be used to connect to Lex.

The `eventUrl` is where Nexmo will send events regarding the connection to the Lex Connector so that your application can be aware of the start and end of a session. Currently Nexmo does not share any data or events on the requests to and from Lex - the only events sent are the start and end of the call.

The `Content-Type` is a fixed value and should be `audio/l16;rate=8000`.
