---
title: Websockets
description: You can connect the audio of a call to a websocket to work with it in real time.
navigation_weight: 7
---

# Websockets [Beta]

## Overview

The Nexmo Voice API allows you to connect to a call via a WebSocket. This means that you will have a real-time two-way stream of the raw audio in the call delivered to you over the WebSocket protocol. This allows you to connect the audio to platforms such as sentiment analysis, real-time transcription systems, and artificial intelligence.

You can also send audio back into the call over this interface.

The WebSocket is an endpoint in the same way that a phone or SIP address is. This means it is a participant in your call and not a passive monitor like a recording. If you connect a WebSocket to a conference call, or a third-party in a 1-1 call, the audio it receives is a mix of all the audio in the call. It is not possible to receive a single leg of the conversation via the WebSocket.

The Nexmo Voice API acts as the client when establishing the WebSocket connection. As the application developer you need to make a compatible server available to:

* return an NCCO instructing Nexmo to connect to your WebSocket endpoint
* accept this WebSocket connection
* handle JSON text-based protocol messages
* handle mixed call audio binary messages

## Connecting to a WebSocket

To instruct Nexmo to connect to a WebSocket your application server must return an [NCCO](/voice/voice-api/guides/ncco) when requested from your Nexmo Application's [answer_url](/voice/voice-api/guides/call-flow#answer-url-payload). In order to do this the NCCO must contain a `connect` action with an `endpoint.type` of `websocket`. For example:

``` json
[
    {
       "action": "connect",
       "endpoint": [
           {
                "type": "websocket",
                "uri": "wss://example.com/socket",
                "content-type": "audio/l16;rate=16000",
                "headers": {
                    "name": "J Doe",
                    "age": 40,
                    "address": {
                        "line_1": "Apartment 14",
                        "line_2": "123 Example Street",
                        "city": "New York City"
                    },
                    "system_roles": [183493, 1038492, 22],
                    "enable_auditing": false
                }
           }
       ]
     }
]
```

The `uri` identifies the endpoint of your WebSocket server that Nexmo will connect to.

To choose the sampling rate set the `content-type` property to `audio/l16;rate=16000` or `audio/l16;rate=8000` depending on if you need the data at 16kHz or 8kHz. Most realtime transcription services work best with audio at 8kHz.

You can send additional optional properties to your WebSocket server by adding key/value pairs to a `headers` property. The maximum length of the `headers` data is 512 bytes.

## Handling Incoming WebSocket Messages

### First Message

The initial message sent on an established WebSocket connection will be text-based and contain a JSON payload, it will have the `event` field set to `websocket:connected` and detail the audio format in `content-type`, along with any other metadata that you have put in the `headers` property of the WebSocket endpoint in your NCCO `connect`. The `headers` property is not present on the JSON payload so the properties are at the top-level of the JSON. For example:

``` json
{
    "event":"websocket:connected",
    "content-type":"audio/l16;rate=16000",
    "prop1": "value1",
    "prop2": "value2"
}
```

Consider the following `connect` action example:

``` json
[
    {
       "action": "connect",
       "endpoint": [
           {
              "type": "websocket",
              "uri": "wss://example.com/socket",
              "content-type": "audio/l16;rate=16000", 
              "headers": {
                 "language": "en-GB",
                 "callerID": "447700900123"
              }
           }
       ]
     }
]
```

This results in the following JSON in the first message on the WebSocket:

``` json
{
    "event":"websocket:connected",
    "content-type":"audio/l16;rate=16000",
    "language": "en-GB",
    "callerID": "447700900123"
}
```
After the initial text message subsequent messages on the WebSocket can be text or binary.

### Binary Audio Messages

Messages that are binary represent the audio of the call. The audio codec presently supported on the WebSocket interface is Linear PCM 16-bit, with either a 8kHz or a 16kHz sample rate, and a 20ms frame size.

To choose the sampling rate set the `Content-Type` property to `audio/l16;rate=16000` or `audio/l16;rate=8000` depending on if you need the data at 16kHz or 8kHz. Most realtime transcription services work best with audio at 8kHz.

Each message will be a 20ms sample of the audio from the call. If you choose the 8kHz rate each message will be 320 bytes. Choosing the 16kHz rate will result in each message being 640 bytes. This is summarized in the following table:

| Sampling rate (samples per second) | Number of samples in 20ms | Bytes per message |
|----|----|----|
| 8000 | 160 | 160 x 2 = 320 |
| 16000 | 320 | 320 x 2 = 640 |

### JSON Messages

Various JSON text-based messages may be sent at any point in the call, developers should handle these appropriately and examine the `event` field to determine the message type and if it is of interest.

### DTMF Events

If any party on the call connected to the websocket sends a DTMF tone this will trigger an event on the websocket, this event is a *text* message with a JSON payload, it will be interleaved between the audio frames and have the following format:

```json
{"event":"websocket:dtmf","digit":"5","duration":260}
```

You will receive one event for each keypress and each event will contain only one digit.

* `event` allows you to identify it as a DTMF event
* `digit` contains the digit pressed `0-9` `*` or `#`
* `duration` is the duration the key was pressed for in milliseconds, on most digital phone systems this will be a fixed length.

## Writing audio to the WebSocket

You can send audio back into the call by writing binary messages to the WebSocket. The audio must be in the same format as described in the previous section. It is important that each message is 320 or 640 bytes (depending on sample rate) and contains 20ms of audio.

You can send the messages at a faster than real-time rate and they will be buffered for playing at the Nexmo end. So for example, you can send an entire file to the socket in one write, providing the 320/640 byte per message restriction is observed. Nexmo will only buffer 1024 messages which should be enough for around 20sec of audio, if your file is longer than this you should implement a delay of 18-19ms between each message, or consider using the [REST API to play an audio file](/voice/voice-api/code-snippets/play-an-audio-stream-into-a-call/).


